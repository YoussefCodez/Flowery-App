import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_occasions_use_case.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_products_of_specific_occasion_use_case.dart';
import 'package:flowery/features/occasions/presentation/view_model/cubit/occasion_view_model.dart';
import 'package:flowery/features/occasions/presentation/view_model/events/occasions_events.dart';
import 'package:flowery/features/occasions/presentation/view_model/states/occasions_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetOccasionsUseCase extends Mock implements GetOccasionsUseCase {}

class MockGetProductsOfSpecificOccasionUseCase extends Mock
    implements GetProductsOfSpecificOccasionUseCase {}

void main() {
  late OccasionViewModel viewModel;
  late MockGetOccasionsUseCase mockGetOccasionsUseCase;
  late MockGetProductsOfSpecificOccasionUseCase
  mockGetProductsOfSpecificOccasionUseCase;

  setUp(() {
    mockGetOccasionsUseCase = MockGetOccasionsUseCase();
    mockGetProductsOfSpecificOccasionUseCase =
        MockGetProductsOfSpecificOccasionUseCase();
    viewModel = OccasionViewModel(
      mockGetOccasionsUseCase,
      mockGetProductsOfSpecificOccasionUseCase,
    );
  });

  blocTest<OccasionViewModel, OccasionsStates>(
    "Testing Occasion view model when the occasions and the products are retrived successfully",

    build: () {
      when(() => mockGetOccasionsUseCase.call()).thenAnswer(
        (_) async => Success<List<OccasionEntity>>(
          data: [
            OccasionEntity(name: "Occasion-1", id: "1"),
            OccasionEntity(name: "Occasion-2", id: "2"),
          ],
        ),
      );

      when(() => mockGetProductsOfSpecificOccasionUseCase.call("1")).thenAnswer(
        (_) async => Success<List<ProductEntity>>(
          data: [
            ProductEntity(
              title: 'product-1',
              description: 'product-1-description',
              imgCover: 'cover-image',
              price: 100,
              priceAfterDiscount: 80,
              discount: 20,
              quantity: 10,
              sold: 5,
              images: [],
            ),
            ProductEntity(
              title: 'product-2',
              description: 'product-2-description',
              imgCover: 'cover-image',
              price: 100,
              priceAfterDiscount: 80,
              discount: 20,
              quantity: 10,
              sold: 5,
              images: [],
            ),
          ],
        ),
      );

      return viewModel;
    },
    act: (viewModel) {
      viewModel.doEvent(GetOccasionsEvent());
    },
    expect: () => [
      isA<OccasionsLoadingState>(),
      isA<OccasionsSuccessState>(),
      isA<OccasionsSuccessState>(),
    ],
    verify: (_) {
      verify(() => mockGetOccasionsUseCase.call()).called(1);
      verify(
        () => mockGetProductsOfSpecificOccasionUseCase.call(any()),
      ).called(1);
    },
  );

  blocTest<OccasionViewModel, OccasionsStates>(
    "Testing Occasion view model when the occasions are retrived successfully but no products for specific occasion",

    build: () {
      when(() => mockGetOccasionsUseCase.call()).thenAnswer(
        (_) async => Success<List<OccasionEntity>>(
          data: [
            OccasionEntity(name: "Occasion-1", id: "1"),
            OccasionEntity(name: "Occasion-2", id: "2"),
          ],
        ),
      );

      when(
        () => mockGetProductsOfSpecificOccasionUseCase.call("1"),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(data: []));

      return viewModel;
    },
    act: (viewModel) {
      viewModel.doEvent(GetOccasionsEvent());
    },
    expect: () => [
      isA<OccasionsLoadingState>(),
      isA<OccasionsSuccessState>(),
      isA<OccasionsSuccessState>(),
    ],
    verify: (_) {
      verify(() => mockGetOccasionsUseCase.call()).called(1);
      verify(
        () => mockGetProductsOfSpecificOccasionUseCase.call(any()),
      ).called(1);
    },
  );

  blocTest<OccasionViewModel, OccasionsStates>(
    "Testing Occasion view model when there are no occasions located",

    build: () {
      when(
        () => mockGetOccasionsUseCase.call(),
      ).thenAnswer((_) async => Success<List<OccasionEntity>>(data: []));

      return viewModel;
    },
    act: (viewModel) {
      viewModel.doEvent(GetOccasionsEvent());
    },
    expect: () => [isA<OccasionsLoadingState>(), isA<OccasionsSuccessState>()],
    verify: (_) {
      verify(() => mockGetOccasionsUseCase.call()).called(1);
    },
  );
}
