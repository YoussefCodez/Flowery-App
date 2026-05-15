import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/categories/domain/entities/category_entity.dart';
import 'package:flowery/features/categories/domain/entities/product_entity.dart';
import 'package:flowery/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:flowery/features/categories/domain/use_cases/get_products_by_category_usecase.dart';
import 'package:flowery/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowery/features/categories/presentation/view_model/events/categories_event.dart';
import 'package:flowery/features/categories/presentation/view_model/states/categories_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllCategoriesUseCase extends Mock
    implements GetAllCategoriesUseCase {}

class MockGetProductsByCategoryUseCase extends Mock
    implements GetProductsByCategoryUseCase {}

void main() {
  late MockGetAllCategoriesUseCase mockGetAllCategoriesUseCase;
  late MockGetProductsByCategoryUseCase mockGetProductsByCategoryUseCase;

  const tCategories = [
    CategoryEntity(id: '1', name: 'Roses', slug: 'roses'),
    CategoryEntity(id: '2', name: 'Lilies', slug: 'lilies'),
  ];

  const tProducts = [
    ProductEntity(id: '101', title: 'Red Rose Bouquet', price: 49.99),
    ProductEntity(id: '102', title: 'White Lily Bundle', price: 35.00),
  ];

  const tFailure = ServerFailure(errorMessage: 'Server error occurred');
  const tCategoryId = 'cat-123';

  setUp(() {
    mockGetAllCategoriesUseCase = MockGetAllCategoriesUseCase();
    mockGetProductsByCategoryUseCase = MockGetProductsByCategoryUseCase();
  });

  CategoriesCubit buildCubit() => CategoriesCubit(
        mockGetAllCategoriesUseCase,
        mockGetProductsByCategoryUseCase,
      );

  group('initial state', () {
    test('should have a default CategoriesState as the initial state', () {
      final cubit = buildCubit();
      expect(cubit.state, const CategoriesState());
      expect(cubit.state.categoriesState.state, StateType.initial);
      expect(cubit.state.productsState.state, StateType.initial);
    });
  });

  group('doEvent(GetAllCategoriesEvent)', () {
    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, success] states when UseCase is successful',
      build: buildCubit,
      setUp: () {
        when(() => mockGetAllCategoriesUseCase.call())
            .thenAnswer((_) async => const Success(data: tCategories));
      },
      act: (cubit) => cubit.doEvent(GetAllCategoriesEvent()),
      expect: () => [
        const CategoriesState(
          categoriesState: BaseState.loading(),
        ),
        const CategoriesState(
          categoriesState: BaseState.success(tCategories),
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllCategoriesUseCase.call()).called(1);
      },
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, success([])] states when data is null',
      build: buildCubit,
      setUp: () {
        when(() => mockGetAllCategoriesUseCase.call())
            .thenAnswer((_) async => const Success(data: null));
      },
      act: (cubit) => cubit.doEvent(GetAllCategoriesEvent()),
      expect: () => [
        const CategoriesState(categoriesState: BaseState.loading()),
        const CategoriesState(
          categoriesState: BaseState.success([]),
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, error] states when UseCase fails with Failure',
      build: buildCubit,
      setUp: () {
        when(() => mockGetAllCategoriesUseCase.call())
            .thenAnswer((_) async => const Error(exception: tFailure));
      },
      act: (cubit) => cubit.doEvent(GetAllCategoriesEvent()),
      expect: () => [
        const CategoriesState(categoriesState: BaseState.loading()),
        const CategoriesState(
          categoriesState: BaseState.error(tFailure),
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, error] states when UseCase fails with a generic Exception',
      build: buildCubit,
      setUp: () {
        final ex = Exception('Unknown error');
        when(() => mockGetAllCategoriesUseCase.call())
            .thenAnswer((_) async => Error(exception: ex));
      },
      act: (cubit) => cubit.doEvent(GetAllCategoriesEvent()),
      expect: () => [
        const CategoriesState(categoriesState: BaseState.loading()),
        isA<CategoriesState>().having(
          (s) => s.categoriesState.state,
          'state type',
          StateType.error,
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should not affect productsState when loading categories',
      build: buildCubit,
      setUp: () {
        when(() => mockGetAllCategoriesUseCase.call())
            .thenAnswer((_) async => const Success(data: tCategories));
      },
      act: (cubit) => cubit.doEvent(GetAllCategoriesEvent()),
      expect: () => [
        isA<CategoriesState>().having(
          (s) => s.productsState.state,
          'productsState stays initial during loading',
          StateType.initial,
        ),
        isA<CategoriesState>().having(
          (s) => s.productsState.state,
          'productsState stays initial after success',
          StateType.initial,
        ),
      ],
    );
  });

  group('doEvent(GetProductsByCategoryEvent)', () {
    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, success] states when UseCase succeeds with categoryId',
      build: buildCubit,
      setUp: () {
        when(() => mockGetProductsByCategoryUseCase.call(tCategoryId))
            .thenAnswer((_) async => const Success(data: tProducts));
      },
      act: (cubit) =>
          cubit.doEvent(GetProductsByCategoryEvent(tCategoryId)),
      expect: () => [
        const CategoriesState(productsState: BaseState.loading()),
        const CategoriesState(
          productsState: BaseState.success(tProducts),
        ),
      ],
      verify: (_) {
        verify(() => mockGetProductsByCategoryUseCase.call(tCategoryId))
            .called(1);
      },
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, success] states when passing null as categoryId',
      build: buildCubit,
      setUp: () {
        when(() => mockGetProductsByCategoryUseCase.call(null))
            .thenAnswer((_) async => const Success(data: tProducts));
      },
      act: (cubit) => cubit.doEvent(GetProductsByCategoryEvent()),
      expect: () => [
        const CategoriesState(productsState: BaseState.loading()),
        const CategoriesState(
          productsState: BaseState.success(tProducts),
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, success([])] states when data is null',
      build: buildCubit,
      setUp: () {
        when(() => mockGetProductsByCategoryUseCase.call(tCategoryId))
            .thenAnswer((_) async => const Success(data: null));
      },
      act: (cubit) =>
          cubit.doEvent(GetProductsByCategoryEvent(tCategoryId)),
      expect: () => [
        const CategoriesState(productsState: BaseState.loading()),
        const CategoriesState(
          productsState: BaseState.success([]),
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should emit [loading, error] states when UseCase fails with Failure',
      build: buildCubit,
      setUp: () {
        when(() => mockGetProductsByCategoryUseCase.call(tCategoryId))
            .thenAnswer((_) async => const Error(exception: tFailure));
      },
      act: (cubit) =>
          cubit.doEvent(GetProductsByCategoryEvent(tCategoryId)),
      expect: () => [
        const CategoriesState(productsState: BaseState.loading()),
        const CategoriesState(
          productsState: BaseState.error(tFailure),
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'should not affect categoriesState when loading products',
      build: buildCubit,
      setUp: () {
        when(() => mockGetProductsByCategoryUseCase.call(tCategoryId))
            .thenAnswer((_) async => const Success(data: tProducts));
      },
      act: (cubit) =>
          cubit.doEvent(GetProductsByCategoryEvent(tCategoryId)),
      expect: () => [
        isA<CategoriesState>().having(
          (s) => s.categoriesState.state,
          'categoriesState stays initial during loading',
          StateType.initial,
        ),
        isA<CategoriesState>().having(
          (s) => s.categoriesState.state,
          'categoriesState stays initial after success',
          StateType.initial,
        ),
      ],
    );
  });

  group('State isolation between events', () {
    blocTest<CategoriesCubit, CategoriesState>(
      'should preserve the value of the other state when running sequential events',
      build: buildCubit,
      setUp: () {
        when(() => mockGetAllCategoriesUseCase.call())
            .thenAnswer((_) async => const Success(data: tCategories));
        when(() => mockGetProductsByCategoryUseCase.call(tCategoryId))
            .thenAnswer((_) async => const Success(data: tProducts));
      },
      act: (cubit) async {
        await cubit.doEvent(GetAllCategoriesEvent());
        await cubit.doEvent(GetProductsByCategoryEvent(tCategoryId));
      },
      verify: (cubit) {
        expect(cubit.state.categoriesState.state, StateType.success);
        expect(cubit.state.productsState.state, StateType.success);
        expect(cubit.state.categoriesState.data, tCategories);
        expect(cubit.state.productsState.data, tProducts);
      },
    );
  });
}
