import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_occasions_use_case.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_products_of_specific_occasion_use_case.dart';
import 'package:flowery/features/occasions/presentation/view_model/cubit/occasion_view_model.dart';
import 'package:flowery/features/occasions/presentation/view_model/events/occasions_events.dart';
import 'package:flowery/features/occasions/presentation/view_model/states/occasions_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOccasionsUseCase extends Mock implements GetOccasionsUseCase {}

class MockGetProductsOfSpecificOccasionUseCase extends Mock
    implements GetProductsOfSpecificOccasionUseCase {}

void main() {
  late OccasionViewModel viewModel;
  late MockGetOccasionsUseCase mockGetOccasionsUseCase;
  late MockGetProductsOfSpecificOccasionUseCase
  mockGetProductsOfSpecificOccasionUseCase;

  final occasions = [
    OccasionEntity(name: "Occasion-1", id: "1"),
    OccasionEntity(name: "Occasion-2", id: "2"),
  ];

  final products = [
    ProductEntity(
      title: 'product-1',
      description: 'description',
      imgCover: 'image',
      price: 100,
      priceAfterDiscount: 80,
      discount: 20,
      quantity: 10,
      sold: 5,
      images: [],
    ),
    ProductEntity(
      title: 'product-2',
      description: 'description',
      imgCover: 'image',
      price: 100,
      priceAfterDiscount: 80,
      discount: 20,
      quantity: 10,
      sold: 5,
      images: [],
    ),
  ];

  final errorMessage = "An error has occured";

  setUpAll(() {
    mockGetOccasionsUseCase = MockGetOccasionsUseCase();

    mockGetProductsOfSpecificOccasionUseCase =
        MockGetProductsOfSpecificOccasionUseCase();
  });
  group("Testing occasions and the first occasion products", () {
    blocTest<OccasionViewModel, OccasionsState>(
      "Getting the occasions then fetch the first occasion prodcuts",

      // Arrange
      setUp: (() {
        when(() => mockGetOccasionsUseCase.call()).thenAnswer(
          (_) async => Success<List<OccasionEntity>>(data: occasions),
        );

        when(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[0].id),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(data: products));
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetOccasionsEvent());
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingOccasions: true),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          isLoadingOccasions: false,
        ),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          isLoadingProducts: true,
        ),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          products: products,
        ),
      ],

      verify: (_) {
        verify(() => mockGetOccasionsUseCase.call()).called(1);

        verify(
          () => mockGetProductsOfSpecificOccasionUseCase.call("1"),
        ).called(1);
      },
    );

    blocTest<OccasionViewModel, OccasionsState>(
      "Getting the occasions then fetch but the first product is empty",

      // Arrange
      setUp: (() {
        when(() => mockGetOccasionsUseCase.call()).thenAnswer(
          (_) async => Success<List<OccasionEntity>>(data: occasions),
        );

        when(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[0].id),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(data: []));
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetOccasionsEvent());
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingOccasions: true),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          isLoadingOccasions: false,
        ),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          isLoadingProducts: true,
        ),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          products: [],
        ),
      ],

      verify: (_) {
        verify(() => mockGetOccasionsUseCase.call()).called(1);

        verify(
          () => mockGetProductsOfSpecificOccasionUseCase.call("1"),
        ).called(1);
      },
    );

    blocTest<OccasionViewModel, OccasionsState>(
      "Getting the occasions then fetch but the first occasion prodcut returns error",

      // Arrange
      setUp: (() {
        when(() => mockGetOccasionsUseCase.call()).thenAnswer(
          (_) async => Success<List<OccasionEntity>>(data: occasions),
        );

        when(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[0].id),
        ).thenAnswer(
          (_) async =>
              Error<List<ProductEntity>>(exception: Exception(errorMessage)),
        );
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetOccasionsEvent());
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingOccasions: true),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          isLoadingOccasions: false,
        ),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          isLoadingProducts: true,
        ),

        OccasionsState(
          names: [occasions[0].name, occasions[1].name],
          ids: [occasions[0].id, occasions[1].id],
          errorMessage: Exception(errorMessage).toString(),
        ),
      ],

      verify: (_) {
        verify(() => mockGetOccasionsUseCase.call()).called(1);

        verify(
          () => mockGetProductsOfSpecificOccasionUseCase.call("1"),
        ).called(1);
      },
    );

    blocTest<OccasionViewModel, OccasionsState>(
      "Failed to get the occasions",

      // Arrange
      setUp: (() {
        when(() => mockGetOccasionsUseCase.call()).thenAnswer(
          (_) async =>
              Error<List<OccasionEntity>>(exception: Exception(errorMessage)),
        );
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetOccasionsEvent());
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingOccasions: true),

        OccasionsState(
          isLoadingOccasions: false,
          errorMessage: Exception(errorMessage).toString(),
        ),
      ],

      verify: (_) {
        verify(() => mockGetOccasionsUseCase.call()).called(1);
      },
    );
  });

  group("Testing prodcuts", () {
    blocTest<OccasionViewModel, OccasionsState>(
      "Fetching a specific occasion products and return products successfully",

      // Arrange
      setUp: (() {
        when(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[1].id),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(data: products));
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          GetProductsOfSpecificOccasion(),
          occasionId: occasions[1].id,
        );
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingProducts: true),

        OccasionsState(products: products, isLoadingProducts: false),
      ],

      verify: (_) {
        verify(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[1].id),
        ).called(1);
      },
    );

    blocTest<OccasionViewModel, OccasionsState>(
      "Fetching a specific occasion products and return empty products",

      // Arrange
      setUp: (() {
        when(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[1].id),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(data: []));
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          GetProductsOfSpecificOccasion(),
          occasionId: occasions[1].id,
        );
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingProducts: true),

        OccasionsState(products: [], isLoadingProducts: false),
      ],

      verify: (_) {
        verify(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[1].id),
        ).called(1);
      },
    );

    blocTest<OccasionViewModel, OccasionsState>(
      "Fetching a specific occasion products and return error",

      // Arrange
      setUp: (() {
        when(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[1].id),
        ).thenAnswer(
          (_) async =>
              Error<List<ProductEntity>>(exception: Exception(errorMessage)),
        );
      }),
      build: () {
        viewModel = OccasionViewModel(
          mockGetOccasionsUseCase,
          mockGetProductsOfSpecificOccasionUseCase,
        );

        return viewModel;
      },

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          GetProductsOfSpecificOccasion(),
          occasionId: occasions[1].id,
        );
      },

      // Assert
      expect: () => [
        const OccasionsState(isLoadingProducts: true),

        OccasionsState(
          errorMessage: Exception(errorMessage).toString(),
          isLoadingProducts: false,
        ),
      ],

      verify: (_) {
        verify(
          () => mockGetProductsOfSpecificOccasionUseCase.call(occasions[1].id),
        ).called(1);
      },
    );
  });
}
