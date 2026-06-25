import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/categories/data/datasources/get_categories_data_source.dart';
import 'package:flowery/features/categories/data/models/category_model.dart';
import 'package:flowery/features/categories/data/models/category_response_model.dart';
import 'package:flowery/features/categories/data/models/product_model.dart';
import 'package:flowery/features/categories/data/models/product_response_model.dart';
import 'package:flowery/features/categories/data/repositories/get_categories_impl.dart';
import 'package:flowery/features/categories/domain/entities/category_entity.dart';
import 'package:flowery/features/categories/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCategoriesDataSource extends Mock
    implements GetCategoriesDataSourceContract {}

void main() {
  late MockGetCategoriesDataSource mockDataSource;
  late GetCategoriesImpl repository;

  setUp(() {
    mockDataSource = MockGetCategoriesDataSource();
    repository = GetCategoriesImpl(mockDataSource);
  });

  CategoryModel tCategoryModel() => CategoryModel(
    id: '1',
    name: 'Roses',
    slug: 'roses',
    image: 'https://example.com/roses.jpg',
  );

  ProductModel tProductModel() => ProductModel(
    id: '101',
    title: 'Red Rose Bouquet',
    slug: 'red-rose-bouquet',
    price: 49.99,
    category: '1',
  );

  CategoryEntity tCategoryEntity() => const CategoryEntity(
    id: '1',
    name: 'Roses',
    slug: 'roses',
    image: 'https://example.com/roses.jpg',
  );

  ProductEntity tProductEntity() => const ProductEntity(
    id: '101',
    title: 'Red Rose Bouquet',
    slug: 'red-rose-bouquet',
    price: 49.99,
    category: '1',
  );

  group('getAllCategories', () {
    test(
      'should return Success with a list of CategoryEntity when the DataSource succeeds',
      () async {
        // arrange
        when(() => mockDataSource.getAllCategories()).thenAnswer(
          (_) async => Success(
            data: CategoryResponseModel(
              message: 'success',
              categories: [tCategoryModel()],
            ),
          ),
        );

        // act
        final result = await repository.getAllCategories();

        // assert
        expect(result, isA<Success<List<CategoryEntity>>>());
        final success = result as Success<List<CategoryEntity>>;
        expect(success.data?.length, 1);
        expect(success.data?.first, tCategoryEntity());
        verify(() => mockDataSource.getAllCategories()).called(1);
      },
    );

    test(
      'should return Success with an empty list when data is null',
      () async {
        // arrange
        when(
          () => mockDataSource.getAllCategories(),
        ).thenAnswer((_) async => const Success(data: null));

        // act
        final result = await repository.getAllCategories();

        // assert
        expect(result, isA<Success<List<CategoryEntity>>>());
        final success = result as Success<List<CategoryEntity>>;
        expect(success.data, isEmpty);
      },
    );

    test(
      'should return Success with an empty list when categories are null in the response',
      () async {
        // arrange
        when(() => mockDataSource.getAllCategories()).thenAnswer(
          (_) async => Success(data: CategoryResponseModel(categories: null)),
        );

        // act
        final result = await repository.getAllCategories();

        // assert
        expect(result, isA<Success<List<CategoryEntity>>>());
        final success = result as Success<List<CategoryEntity>>;
        expect(success.data, isEmpty);
      },
    );

    test('should correctly convert CategoryModel to CategoryEntity', () async {
      // arrange
      when(() => mockDataSource.getAllCategories()).thenAnswer(
        (_) async => Success(
          data: CategoryResponseModel(categories: [tCategoryModel()]),
        ),
      );

      // act
      final result = await repository.getAllCategories();
      final success = result as Success<List<CategoryEntity>>;
      final entity = success.data!.first;

      // assert
      expect(entity.id, '1');
      expect(entity.name, 'Roses');
      expect(entity.slug, 'roses');
      expect(entity.image, 'https://example.com/roses.jpg');
    });

    test('should return Error when the DataSource fails', () async {
      // arrange
      final tException = ServerFailure(errorMessage: 'Server error');
      when(
        () => mockDataSource.getAllCategories(),
      ).thenAnswer((_) async => Error(exception: tException));

      // act
      final result = await repository.getAllCategories();

      // assert
      expect(result, isA<Error<List<CategoryEntity>>>());
      final error = result as Error<List<CategoryEntity>>;
      expect(error.exception, tException);
    });

    test(
      'should return the exact same exception from the DataSource without modifying it',
      () async {
        // arrange
        final tException = Exception('Network error');
        when(
          () => mockDataSource.getAllCategories(),
        ).thenAnswer((_) async => Error(exception: tException));

        // act
        final result = await repository.getAllCategories();

        // assert
        final error = result as Error<List<CategoryEntity>>;
        expect(error.exception, same(tException));
      },
    );
  });

  group('getProductsByCategory', () {
    const tCategoryId = 'cat-123';

    test(
      'should return Success with a list of ProductEntity when the DataSource succeeds',
      () async {
        // arrange
        when(
          () => mockDataSource.getProductsByCategory(tCategoryId, null),
        ).thenAnswer(
          (_) async => Success(
            data: ProductResponseModel(
              message: 'success',
              products: [tProductModel()],
            ),
          ),
        );

        // act
        final result = await repository.getProductsByCategory(
          tCategoryId,
          null,
        );

        // assert
        expect(result, isA<Success<List<ProductEntity>>>());
        final success = result as Success<List<ProductEntity>>;
        expect(success.data?.length, 1);
        expect(success.data?.first, tProductEntity());
        verify(
          () => mockDataSource.getProductsByCategory(tCategoryId, null),
        ).called(1);
      },
    );

    test('should pass null as categoryId to the DataSource', () async {
      // arrange
      when(() => mockDataSource.getProductsByCategory(null, null)).thenAnswer(
        (_) async =>
            Success(data: ProductResponseModel(products: [tProductModel()])),
      );

      // act
      final result = await repository.getProductsByCategory(null, null);

      // assert
      expect(result, isA<Success<List<ProductEntity>>>());
      verify(() => mockDataSource.getProductsByCategory(null, null)).called(1);
    });

    test(
      'should return Success with an empty list when data is null',
      () async {
        // arrange
        when(
          () => mockDataSource.getProductsByCategory(tCategoryId, null),
        ).thenAnswer((_) async => const Success(data: null));

        // act
        final result = await repository.getProductsByCategory(
          tCategoryId,
          null,
        );

        // assert
        final success = result as Success<List<ProductEntity>>;
        expect(success.data, isEmpty);
      },
    );

    test(
      'should return Success with an empty list when products are null in the response',
      () async {
        // arrange
        when(
          () => mockDataSource.getProductsByCategory(tCategoryId, null),
        ).thenAnswer(
          (_) async => Success(data: ProductResponseModel(products: null)),
        );

        // act
        final result = await repository.getProductsByCategory(
          tCategoryId,
          null,
        );

        // assert
        final success = result as Success<List<ProductEntity>>;
        expect(success.data, isEmpty);
      },
    );

    test('should correctly convert ProductModel to ProductEntity', () async {
      // arrange
      when(
        () => mockDataSource.getProductsByCategory(tCategoryId, null),
      ).thenAnswer(
        (_) async =>
            Success(data: ProductResponseModel(products: [tProductModel()])),
      );

      // act
      final result = await repository.getProductsByCategory(tCategoryId, null);
      final success = result as Success<List<ProductEntity>>;
      final entity = success.data!.first;

      // assert
      expect(entity.id, '101');
      expect(entity.title, 'Red Rose Bouquet');
      expect(entity.price, 49.99);
      expect(entity.category, '1');
    });

    test('should return Error when the DataSource fails', () async {
      // arrange
      final tException = ServerFailure(errorMessage: 'Not found');
      when(
        () => mockDataSource.getProductsByCategory(tCategoryId, null),
      ).thenAnswer((_) async => Error(exception: tException));

      // act
      final result = await repository.getProductsByCategory(tCategoryId, null);

      // assert
      expect(result, isA<Error<List<ProductEntity>>>());
      final error = result as Error<List<ProductEntity>>;
      expect(error.exception, tException);
    });

    test(
      'should pass sort option to DataSource and return mapped products',
      () async {
        // arrange
        const tSortOption = 'price';

        when(
          () => mockDataSource.getProductsByCategory(tCategoryId, tSortOption),
        ).thenAnswer(
          (_) async =>
              Success(data: ProductResponseModel(products: [tProductModel()])),
        );

        // act
        final result = await repository.getProductsByCategory(
          tCategoryId,
          tSortOption,
        );

        // assert
        expect(result, isA<Success<List<ProductEntity>>>());

        verify(
          () => mockDataSource.getProductsByCategory(tCategoryId, tSortOption),
        ).called(1);
      },
    );

    test('should pass sort option when categoryId is null', () async {
      // arrange
      const tSortOption = 'price';

      when(
        () => mockDataSource.getProductsByCategory(null, tSortOption),
      ).thenAnswer(
        (_) async =>
            Success(data: ProductResponseModel(products: [tProductModel()])),
      );

      // act
      await repository.getProductsByCategory(null, tSortOption);

      // assert
      verify(
        () => mockDataSource.getProductsByCategory(null, tSortOption),
      ).called(1);
    });

    test('should pass both categoryId and sortOption as null', () async {
      // arrange
      when(() => mockDataSource.getProductsByCategory(null, null)).thenAnswer(
        (_) async =>
            Success(data: ProductResponseModel(products: [tProductModel()])),
      );

      // act
      await repository.getProductsByCategory(null, null);

      // assert
      verify(() => mockDataSource.getProductsByCategory(null, null)).called(1);
    });
  });
}
