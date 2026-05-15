import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/categories/api/api_client/categories_api_client.dart';
import 'package:flowery/features/categories/api/data_source/get_categories_data_source_impl.dart';
import 'package:flowery/features/categories/data/models/category_model.dart';
import 'package:flowery/features/categories/data/models/category_response_model.dart';
import 'package:flowery/features/categories/data/models/product_model.dart';
import 'package:flowery/features/categories/data/models/product_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesApiClient extends Mock implements CategoriesApiClient {}

void main() {
  late MockCategoriesApiClient mockApiClient;
  late GetCategoriesDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockCategoriesApiClient();
    dataSource = GetCategoriesDataSourceImpl(mockApiClient);
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

  CategoryResponseModel tCategoryResponse() => CategoryResponseModel(
        message: 'success',
        categories: [tCategoryModel()],
      );

  ProductResponseModel tProductResponse() => ProductResponseModel(
        message: 'success',
        products: [tProductModel()],
      );

  DioException tDioException() => DioException(
        requestOptions: RequestOptions(path: '/categories'),
        message: 'Connection refused',
        type: DioExceptionType.connectionError,
      );

  group('getAllCategories', () {
    test(
      'should return Success when the API call is successful',
      () async {
        // arrange
        when(() => mockApiClient.getAllCategories())
            .thenAnswer((_) async => tCategoryResponse());

        // act
        final result = await dataSource.getAllCategories();

        // assert
        expect(result, isA<Success<CategoryResponseModel>>());
        final success = result as Success<CategoryResponseModel>;
        expect(success.data?.categories?.length, 1);
        expect(success.data?.categories?.first.name, 'Roses');
        verify(() => mockApiClient.getAllCategories()).called(1);
      },
    );

    test(
      'should return Error<ServerFailure> when a DioException is thrown',
      () async {
        // arrange
        when(() => mockApiClient.getAllCategories()).thenThrow(tDioException());

        // act
        final result = await dataSource.getAllCategories();

        // assert
        expect(result, isA<Error<CategoryResponseModel>>());
        final error = result as Error<CategoryResponseModel>;
        expect(error.exception, isA<ServerFailure>());
        final failure = error.exception as ServerFailure;
        expect(failure.errorMessage, 'Connection refused');
      },
    );

    test(
      'should return Error<Exception> when a non-DioException is thrown',
      () async {
        // arrange
        when(() => mockApiClient.getAllCategories())
            .thenThrow(Exception('Unexpected error'));

        // act
        final result = await dataSource.getAllCategories();

        // assert
        expect(result, isA<Error<CategoryResponseModel>>());
        final error = result as Error<CategoryResponseModel>;
        expect(error.exception, isA<Exception>());
      },
    );

    test(
      'should return Success with empty categories when response data is empty',
      () async {
        // arrange
        when(() => mockApiClient.getAllCategories())
            .thenAnswer((_) async => CategoryResponseModel(categories: []));

        // act
        final result = await dataSource.getAllCategories();

        // assert
        expect(result, isA<Success<CategoryResponseModel>>());
        final success = result as Success<CategoryResponseModel>;
        expect(success.data?.categories, isEmpty);
      },
    );
  });

  group('getProductsByCategory', () {
    const tCategoryId = 'cat-123';

    test(
      'should return Success when the API call is successful with valid categoryId',
      () async {
        // arrange
        when(() => mockApiClient.getProductsByCategory(tCategoryId))
            .thenAnswer((_) async => tProductResponse());

        // act
        final result = await dataSource.getProductsByCategory(tCategoryId);

        // assert
        expect(result, isA<Success<ProductResponseModel>>());
        final success = result as Success<ProductResponseModel>;
        expect(success.data?.products?.length, 1);
        expect(success.data?.products?.first.title, 'Red Rose Bouquet');
        verify(() => mockApiClient.getProductsByCategory(tCategoryId)).called(1);
      },
    );

    test(
      'should pass null as categoryId to the API when invoked with null',
      () async {
        // arrange
        when(() => mockApiClient.getProductsByCategory(null))
            .thenAnswer((_) async => tProductResponse());

        // act
        final result = await dataSource.getProductsByCategory(null);

        // assert
        expect(result, isA<Success<ProductResponseModel>>());
        verify(() => mockApiClient.getProductsByCategory(null)).called(1);
      },
    );

    test(
      'should return Error<ServerFailure> when a DioException is thrown',
      () async {
        // arrange
        when(() => mockApiClient.getProductsByCategory(any()))
            .thenThrow(tDioException());

        // act
        final result = await dataSource.getProductsByCategory(tCategoryId);

        // assert
        expect(result, isA<Error<ProductResponseModel>>());
        final error = result as Error<ProductResponseModel>;
        expect(error.exception, isA<ServerFailure>());
      },
    );

    test(
      'should return Error<Exception> when a non-DioException is thrown',
      () async {
        // arrange
        when(() => mockApiClient.getProductsByCategory(any()))
            .thenThrow(Exception('Unknown error'));

        // act
        final result = await dataSource.getProductsByCategory(tCategoryId);

        // assert
        expect(result, isA<Error<ProductResponseModel>>());
        final error = result as Error<ProductResponseModel>;
        expect(error.exception, isA<Exception>());
      },
    );

    test(
      'should return correct DioException message in ServerFailure',
      () async {
        // arrange
        final dio = DioException(
          requestOptions: RequestOptions(path: '/products'),
          message: 'Timeout exceeded',
          type: DioExceptionType.connectionTimeout,
        );
        when(() => mockApiClient.getProductsByCategory(any())).thenThrow(dio);

        // act
        final result = await dataSource.getProductsByCategory(tCategoryId);

        // assert
        final error = result as Error<ProductResponseModel>;
        final failure = error.exception as ServerFailure;
        expect(failure.errorMessage, 'Timeout exceeded');
      },
    );
  });
}
