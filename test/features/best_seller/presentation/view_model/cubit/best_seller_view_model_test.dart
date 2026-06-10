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

  final errorMessage = "an error has occured";

  final bestSellerProducts = [
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
      id: "1"
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
      id: "2"
    ),
  ];

  setUp(() {
    mockGetBestSellerProductsUseCase = MockGetBestSellerProductsUseCase();
    viewModel = BestSellerViewModel(mockGetBestSellerProductsUseCase);
  });

  blocTest<BestSellerViewModel, BestSellerStates>(
    "Testing best seller view model when it has a list of one or more products",

    setUp: () {
      when(() => mockGetBestSellerProductsUseCase.call()).thenAnswer(
        (_) async =>
            Success<List<BestSellerProductEntity>>(data: bestSellerProducts),
      );
    },

    build: () => viewModel,

    act: (viewModel) {
      viewModel.doEvent(GetBestSellerProductsEvent());
    },
    expect: () => [
      isA<BestSellerLoadingState>(),
      isA<BestSellerSuccessState>().having(
        (state) => state.products,
        "Checking the best seller products are simillar to the expected",
        bestSellerProducts,
      ),
    ],

    verify: (_) {
      verify(() => mockGetBestSellerProductsUseCase.call()).called(1);
    },
  );

  blocTest<BestSellerViewModel, BestSellerStates>(
    "Testing best seller view model when it has an empty list of products",

    setUp: () {
      when(() => mockGetBestSellerProductsUseCase.call()).thenAnswer(
        (_) async => Success<List<BestSellerProductEntity>>(data: []),
      );
    },

    build: () => viewModel,

    act: (viewModel) {
      viewModel.doEvent(GetBestSellerProductsEvent());
    },
    expect: () => [
      isA<BestSellerLoadingState>(),
      isA<BestSellerSuccessState>().having(
        (state) => state.products,
        "Checking the best seller products are empty",
        [],
      ),
    ],

    verify: (_) {
      verify(() => mockGetBestSellerProductsUseCase.call()).called(1);
    },
  );

  blocTest<BestSellerViewModel, BestSellerStates>(
    "Testing best seller view model when it gives error",

    setUp: () {
      when(() => mockGetBestSellerProductsUseCase.call()).thenAnswer(
        (_) async => Error<List<BestSellerProductEntity>>(
          exception: Exception(errorMessage),
        ),
      );
    },

    build: () => viewModel,

    act: (viewModel) {
      viewModel.doEvent(GetBestSellerProductsEvent());
    },
    expect: () => [
      isA<BestSellerLoadingState>(),
      isA<BestSellerErrorState>().having(
        (state) => state.errorMessage,
        "Checking the best seller products are simillar to the expected",
        "Exception: $errorMessage",
      ),
    ],

    verify: (_) {
      verify(() => mockGetBestSellerProductsUseCase.call()).called(1);
    },
  );
}
