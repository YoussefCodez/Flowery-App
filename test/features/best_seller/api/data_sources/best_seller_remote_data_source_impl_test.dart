import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flowery/features/best_seller/api/data_sources/best_seller_remote_data_source_impl.dart';
import 'package:flowery/features/best_seller/data/models/response/best_seller_product_model.dart';
import 'package:flowery/features/best_seller/data/models/response/best_seller_products_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBestSellerApiClient extends Mock implements BestSellerApiClient {}

void main() {
  late BestSellerRemoteDataSourceImpl bestSellerRemoteDataSourceImpl;
  late MockBestSellerApiClient mockBestSellerApiClient;

  final errorMessage = "An error has occured";
  final successMessage = "Successfully retrived";

  final bestSellerProducts = [
    BestSellerProduct(
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
      bestSellerId: '',
    ),
  ];

  setUp(() {
    mockBestSellerApiClient = MockBestSellerApiClient();
    bestSellerRemoteDataSourceImpl = BestSellerRemoteDataSourceImpl(
      apiClient: mockBestSellerApiClient,
    );
  });

  group("Testing Remote Data Sources", () {
    test("Getting Products Response Successfully", () async {
      // Arrange
      when(() => mockBestSellerApiClient.getBestSellerProducts()).thenAnswer(
        (_) async => BestSellerProductsResponseModel(
          message: successMessage,
          bestSeller: bestSellerProducts,
        ),
      );

      // Act
      final response = await bestSellerRemoteDataSourceImpl
          .getBestSellerProducts();

      // Assert
      expect(response, isA<Success<BestSellerProductsResponseModel>>());

      // Act
      final successResponse =
          response as Success<BestSellerProductsResponseModel>;

      // Assert
      expect(successResponse.data?.message, successMessage);
      expect(successResponse.data?.bestSeller, bestSellerProducts);

      // Verify
      verify(() => mockBestSellerApiClient.getBestSellerProducts()).called(1);
    });

    test("Failed to get Prodcuts Response", () async {
      // Arrange
      when(
        () => mockBestSellerApiClient.getBestSellerProducts(),
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
      final response = await bestSellerRemoteDataSourceImpl
          .getBestSellerProducts();

      // Assert
      expect(response, isA<Error<BestSellerProductsResponseModel>>());

      // Act
      final errorResponse = response as Error<BestSellerProductsResponseModel>;

      // Assert
      expect(errorResponse.exception?.toString(), "Exception: $errorMessage");

      // Verify
      verify(
        () => mockBestSellerApiClient.getBestSellerProducts(),
      ).called(1);
    });
  });
}
