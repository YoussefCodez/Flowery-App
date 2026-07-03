import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/api/api_client/occasions_api_client.dart';
import 'package:flowery/features/occasions/api/data_sources/occasions_data_sources_impl.dart';
import 'package:flowery/features/occasions/data/models/response/meta_data_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_products_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasions_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOccasionsApiClient extends Mock implements OccasionsApiClient {}

void main() {
  late OccasionsDataSourcesImpl occasionsDataSourcesImpl;
  late MockOccasionsApiClient mockOccasionsApiClient;

  final occasions = [
    Occasion(
      id: '1',
      name: 'occasion-1',
      slug: 'occasion-1',
      image: 'image-1',
      isSuperAdmin: null,
      createdAt: null,
      updatedAt: null,
      productsCount: 10,
    ),
    Occasion(
      id: '2',
      name: 'occasion-2',
      slug: 'occasion-2',
      image: 'image-2',
      isSuperAdmin: null,
      createdAt: null,
      updatedAt: null,
      productsCount: 5,
    ),
  ];

  final errorMessage = "An error has occured";
  final successMessage = "Successfully retrived";

  final metaData = Metadata(
    currentPage: 1,
    limit: 1,
    totalPages: 1,
    totalItems: 2,
  );

  final products = [
    Product(
      id: 'product-1-id',
      title: 'product-1-title',
      slug: 'product-1-slug',
      description: 'product-1-description',
      imgCover: 'product-1-imgCover',
      images: [],
      price: 110,
      priceAfterDiscount: 100,
      discount: 10,
      rateAvg: 2,
      rateCount: 50,
      sold: 100,
      quantity: 200,
      category: 'gifts',
      occasion: 'occasion-1',
      isSuperAdmin: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
      favoriteId: '123',
      isInWishlist: false,
    ),
  ];
  setUp(() {
    mockOccasionsApiClient = MockOccasionsApiClient();
    occasionsDataSourcesImpl = OccasionsDataSourcesImpl(
      apiClient: mockOccasionsApiClient,
    );
  });
  group("Testing Remote Data Sources", () {
    test("Getting Occasions Response Successfully", () async {
      // Arrange
      when(() => mockOccasionsApiClient.getOccasions()).thenAnswer(
        (_) async => OccasionsResponseModel(
          message: successMessage,
          metadata: metaData,
          occasions: occasions,
        ),
      );

      // Act
      final response = await occasionsDataSourcesImpl.getOccasions();

      // Assert
      expect(response, isA<Success<OccasionsResponseModel>>());

      // Act
      final successResponse = response as Success<OccasionsResponseModel>;

      // Assert
      expect(successResponse.data?.message, successMessage);
      expect(successResponse.data?.metadata, metaData);
      expect(successResponse.data?.occasions, occasions);

      // Verify
      verify(() => mockOccasionsApiClient.getOccasions()).called(1);
    });

    test("Failed to get Occasions Response", () async {
      // Arrange
      when(() => mockOccasionsApiClient.getOccasions()).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {"error": errorMessage},
          ),
        ),
      );

      // Act
      final response = await occasionsDataSourcesImpl.getOccasions();

      // Assert
      expect(response, isA<Error<OccasionsResponseModel>>());

      // Act
      final errorResponse = response as Error<OccasionsResponseModel>;

      // Assert
      expect(errorResponse.exception?.toString(), "Exception: $errorMessage");

      // Verify
      verify(() => mockOccasionsApiClient.getOccasions()).called(1);
    });

    test("Getting Products Response Successfully", () async {
      // Arrange
      when(
        () => mockOccasionsApiClient.getProductsOfSpecificOccasion(
          occasions[0].id!,
        ),
      ).thenAnswer(
        (_) async => OccasionProductsResponseModel(
          message: successMessage,
          metadata: metaData,
          products: products,
        ),
      );

      // Act
      final response = await occasionsDataSourcesImpl
          .getProductsOfSpecificOccasion(occasions[0].id!);

      // Assert
      expect(response, isA<Success<OccasionProductsResponseModel>>());

      // Act
      final successResponse =
          response as Success<OccasionProductsResponseModel>;

      // Assert
      expect(successResponse.data?.message, successMessage);
      expect(successResponse.data?.metadata, metaData);
      expect(successResponse.data?.products, products);

      // Verify
      verify(
        () => mockOccasionsApiClient.getProductsOfSpecificOccasion(
          occasions[0].id!,
        ),
      ).called(1);
    });

    test("Failed to get Prodcuts Response", () async {
      // Arrange
      when(
        () => mockOccasionsApiClient.getProductsOfSpecificOccasion(
          occasions[0].id!,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {"error": errorMessage},
          ),
        ),
      );

      // Act
      final response = await occasionsDataSourcesImpl
          .getProductsOfSpecificOccasion(occasions[0].id!);

      // Assert
      expect(response, isA<Error<OccasionProductsResponseModel>>());

      // Act
      final errorResponse = response as Error<OccasionProductsResponseModel>;

      // Assert
      expect(errorResponse.exception?.toString(), "Exception: $errorMessage");

      // Verify
      verify(
        () => mockOccasionsApiClient.getProductsOfSpecificOccasion(
          occasions[0].id!,
        ),
      ).called(1);
    });
  });
}
