import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:flowery/features/best_seller/domain/use_cases/get_best_seller_products_use_case.dart';
import 'package:flowery/features/best_seller/presentation/view_model/cubit/best_seller_view_model.dart';
import 'package:flowery/features/best_seller/presentation/view_model/events/best_seller_events.dart';
import 'package:flowery/features/best_seller/presentation/view_model/states/best_seller_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetBestSellerProductsUseCase extends Mock
    implements GetBestSellerProductsUseCase {}

void main() {
  late BestSellerViewModel viewModel;
  late MockGetBestSellerProductsUseCase mockGetBestSellerProductsUseCase;

  setUp(() {
    mockGetBestSellerProductsUseCase = MockGetBestSellerProductsUseCase();
    viewModel = BestSellerViewModel(mockGetBestSellerProductsUseCase);
  });

  blocTest<BestSellerViewModel, BestSellerStates>(
    "Testing best seller view model when it has a list of one or more products",

    build: () {
      when(() => mockGetBestSellerProductsUseCase.call()).thenAnswer(
        (_) async => Success<List<BestSellerProductEntity>>(
          data: [
            BestSellerProductEntity(
              title: 'product-1',
              description: 'product-1-description',
              imgCover: 'image-1',
              price: 80,
              priceAfterDiscount: 100,
              discount: 20,
              quantity: 10,
              sold: 5,
              images: [],
            ),
            BestSellerProductEntity(
              title: 'product-2',
              description: 'product-2-description',
              imgCover: 'image-2',
              price: 80,
              priceAfterDiscount: 100,
              discount: 20,
              quantity: 20,
              sold: 10,
              images: [],
            ),
          ],
        ),
      );

      return viewModel;
    },
    act: (viewModel) {
      viewModel.doEvent(GetBestSellerProductsEvent());
    },
    expect: () => [
      isA<BestSellerLoadingState>(),
      isA<BestSellerSuccessState>(),
    ],
    verify: (_) {
      verify(() => mockGetBestSellerProductsUseCase.call()).called(1);
    },
  );

  blocTest<BestSellerViewModel, BestSellerStates>(
    "Testing best seller view model when it has a empty list",

    build: () {
      when(() => mockGetBestSellerProductsUseCase.call()).thenAnswer(
        (_) async => Success<List<BestSellerProductEntity>>(data: []),
      );

      return viewModel;
    },
    act: (viewModel) {
      viewModel.doEvent(GetBestSellerProductsEvent());
    },
    expect: () => [
      isA<BestSellerLoadingState>(),
      isA<BestSellerSuccessState>(),
    ],
    verify: (_) {
      verify(() => mockGetBestSellerProductsUseCase.call()).called(1);
    },
  );

  blocTest<BestSellerViewModel, BestSellerStates>(
    "Testing best seller view model when it has an error",

    build: () {
      when(
        () => mockGetBestSellerProductsUseCase.call(),
      ).thenAnswer((_) async => Error<List<BestSellerProductEntity>>());

      return viewModel;
    },
    act: (viewModel) {
      viewModel.doEvent(GetBestSellerProductsEvent());
    },
    expect: () => [isA<BestSellerLoadingState>(), isA<BestSellerErrorState>()],

    verify: (_) {
      verify(() => mockGetBestSellerProductsUseCase.call()).called(1);
    },
  );
}
