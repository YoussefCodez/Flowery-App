import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/home_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';
import 'package:flowery/featuers/home/domain/home_use_case/get_home_data_use_case.dart';
import 'package:flowery/featuers/home/presentation/view_model/home_cubit.dart';
import 'package:flowery/featuers/home/presentation/view_model/state_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GetHomeDataUseCase])
void main() {
  late HomeViewModel viewModel;
  late MockGetHomeDataUseCase mockGetHomeDataUseCase;

  final fakeCategories = [CategoryEntity(id: '1', name: 'Flowers')];
  final fakeBestSeller = [
    BestSellerEntity(id: '1', title: 'Rose', price: 150.0),
  ];
  final fakeOccasions = [OccasionEntity(id: '1', name: 'Birthday')];

  setUp(() {
    provideDummy<Result<HomeEntity>>(
      const Success<HomeEntity>(data: HomeEntity()),
    );

    mockGetHomeDataUseCase = MockGetHomeDataUseCase();

    viewModel = HomeViewModel(mockGetHomeDataUseCase);
  });

  group('loadHomeData -', () {
    blocTest<HomeViewModel, HomeState>(
      'يـ emit loading ثم success للـ 3 states لما الـ use case يرجع Success',
      build: () {
        when(mockGetHomeDataUseCase()).thenAnswer(
          (_) async => Success<HomeEntity>(
            data: HomeEntity(
              categories: fakeCategories,
              bestSeller: fakeBestSeller,
              occasions: fakeOccasions,
            ),
          ),
        );
        return viewModel;
      },
      act: (bloc) => bloc.loadHomeData(),
      expect: () => [
        predicate<HomeState>((s) => s.isLoading == true),

        predicate<HomeState>(
          (s) =>
              s.categoryState.state == StateType.success &&
              s.bestSellerState.state == StateType.success &&
              s.occasionState.state == StateType.success,
        ),
        predicate<HomeState>((s) => s.isLoading == false),
      ],
      verify: (_) {
        verify(mockGetHomeDataUseCase()).called(1);
      },
    );

    blocTest<HomeViewModel, HomeState>(
      'يـ emit loading ثم error للـ 3 states لما الـ use case يفشل',
      build: () {
        when(mockGetHomeDataUseCase()).thenAnswer(
          (_) async => Error<HomeEntity>(exception: Exception('error')),
        );
        return viewModel;
      },
      act: (bloc) => bloc.loadHomeData(),
      expect: () => [
        predicate<HomeState>((s) => s.isLoading == true),

        predicate<HomeState>(
          (s) =>
              s.categoryState.state == StateType.error &&
              s.bestSellerState.state == StateType.error &&
              s.occasionState.state == StateType.error,
        ),
        predicate<HomeState>((s) => s.isLoading == false),
      ],
      verify: (_) {
        verify(mockGetHomeDataUseCase()).called(1);
      },
    );
  });
}
