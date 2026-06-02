import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';
import 'package:flowery/featuers/home/domain/home_use_case/best_seller_use_case.dart';
import 'package:flowery/featuers/home/domain/home_use_case/category_use_case.dart';
import 'package:flowery/featuers/home/domain/home_use_case/occasion_use_case.dart';
import 'package:flowery/featuers/home/presentation/view_model/home_cubit.dart';
import 'package:flowery/featuers/home/presentation/view_model/home_event.dart';
import 'package:flowery/featuers/home/presentation/view_model/state_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([
  GetCategoriesUseCase,
  GetBestSellerUseCase,
  GetOccasionsUseCase,
])
void main() {
  late HomeViewModel viewModel;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetBestSellerUseCase mockGetBestSellerUseCase;
  late MockGetOccasionsUseCase mockGetOccasionsUseCase;

  final fakeCategories = [CategoryEntity(id: '1', name: 'Flowers')];
  final fakeBestSeller = [
    BestSellerEntity(id: '1', title: 'Rose', price: 150.0),
  ];
  final fakeOccasions = [OccasionEntity(id: '1', name: 'Birthday')];

  setUp(() {
    provideDummy<Result<List<CategoryEntity>>>(
      Success<List<CategoryEntity>>(data: []),
    );
    provideDummy<Result<List<BestSellerEntity>>>(
      Success<List<BestSellerEntity>>(data: []),
    );
    provideDummy<Result<List<OccasionEntity>>>(
      Success<List<OccasionEntity>>(data: []),
    );

    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetBestSellerUseCase = MockGetBestSellerUseCase();
    mockGetOccasionsUseCase = MockGetOccasionsUseCase();

    viewModel = HomeViewModel(
      mockGetCategoriesUseCase,
      mockGetBestSellerUseCase,
      mockGetOccasionsUseCase,
    );
  });

  group('GetAllDataEvent -', () {
    blocTest<HomeViewModel, HomeState>(
      'يـ emit loading ثم success للـ 3 states لما كل الـ use cases تنجح',
      build: () {
        // Arrange: الـ 3 use cases كلهم هيرجعوا Success
        when(mockGetCategoriesUseCase()).thenAnswer(
          (_) async => Success<List<CategoryEntity>>(data: fakeCategories),
        );
        when(mockGetBestSellerUseCase()).thenAnswer(
          (_) async => Success<List<BestSellerEntity>>(data: fakeBestSeller),
        );
        when(mockGetOccasionsUseCase()).thenAnswer(
          (_) async => Success<List<OccasionEntity>>(data: fakeOccasions),
        );
        return viewModel;
      },
      // Act
      act: (bloc) => bloc.doEvent(GetAllDataEvent()),
      // Assert
      expect: () => [
        predicate<HomeState>((s) => s.isLoading == true),

        predicate<HomeState>((s) => s.categoryState.state == StateType.success),
        predicate<HomeState>(
          (s) => s.bestSellerState.state == StateType.success,
        ),
        predicate<HomeState>((s) => s.occasionState.state == StateType.success),

        predicate<HomeState>((s) => s.isLoading == false),
      ],
    );

    blocTest<HomeViewModel, HomeState>(
      'يـ emit loading ثم error للـ 3 states لما كل الـ use cases تفشل',
      build: () {
        // Arrange
        when(mockGetCategoriesUseCase()).thenAnswer(
          (_) async =>
              Error<List<CategoryEntity>>(exception: Exception('error')),
        );
        when(mockGetBestSellerUseCase()).thenAnswer(
          (_) async =>
              Error<List<BestSellerEntity>>(exception: Exception('error')),
        );
        when(mockGetOccasionsUseCase()).thenAnswer(
          (_) async =>
              Error<List<OccasionEntity>>(exception: Exception('error')),
        );
        return viewModel;
      },
      act: (bloc) => bloc.doEvent(GetAllDataEvent()),
      expect: () => [
        predicate<HomeState>((s) => s.isLoading == true),

        predicate<HomeState>((s) => s.categoryState.state == StateType.error),
        predicate<HomeState>((s) => s.bestSellerState.state == StateType.error),
        predicate<HomeState>((s) => s.occasionState.state == StateType.error),

        predicate<HomeState>((s) => s.isLoading == false),
      ],
    );

    blocTest<HomeViewModel, HomeState>(
      'يـ emit success لـ category و error لـ bestSeller و occasion',
      build: () {
        when(mockGetCategoriesUseCase()).thenAnswer(
          (_) async => Success<List<CategoryEntity>>(data: fakeCategories),
        );
        when(mockGetBestSellerUseCase()).thenAnswer(
          (_) async =>
              Error<List<BestSellerEntity>>(exception: Exception('error')),
        );
        when(mockGetOccasionsUseCase()).thenAnswer(
          (_) async =>
              Error<List<OccasionEntity>>(exception: Exception('error')),
        );
        return viewModel;
      },
      act: (bloc) => bloc.doEvent(GetAllDataEvent()),
      expect: () => [
        predicate<HomeState>((s) => s.isLoading == true),
        predicate<HomeState>((s) => s.categoryState.state == StateType.success),
        predicate<HomeState>((s) => s.bestSellerState.state == StateType.error),
        predicate<HomeState>((s) => s.occasionState.state == StateType.error),
        predicate<HomeState>((s) => s.isLoading == false),
      ],
    );
  });
}
