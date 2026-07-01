import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flowery/features/best_seller/data/models/response/best_seller_product_model.dart';
import 'package:flowery/features/best_seller/data/models/response/best_seller_products_response_model.dart';
import 'package:flowery/features/best_seller/data/repo/best_seller_repo_impl.dart';
import 'package:flowery/features/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBestSellerRemoteDataSourceContract extends Mock
    implements BestSellerRemoteDataSourceContract {}

void main() {
  late BestSellerRepoImpl bestSellerRepoImpl;
  late MockBestSellerRemoteDataSourceContract
  mockBestSellerRemoteDataSourceContract;

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

  setUpAll(() {
    mockBestSellerRemoteDataSourceContract =
        MockBestSellerRemoteDataSourceContract();
    bestSellerRepoImpl = BestSellerRepoImpl(
      remoteDataSourceContract: mockBestSellerRemoteDataSourceContract,
    );
  });

  group('Testing Repo', () {
    group('Testing products', () {
      test("Successfuly getting the products", () async {

        // Arrange
        final BestSellerProductsResponseModel bestSellerProductsResponseModel =
            BestSellerProductsResponseModel(
              bestSeller: bestSellerProducts,
              message: successMessage,
            );

        when(
          () => mockBestSellerRemoteDataSourceContract.getBestSellerProducts(),
        ).thenAnswer(
          (_) async => Success<BestSellerProductsResponseModel>(
            data: bestSellerProductsResponseModel,
          ),
        );

        // Act
        final response = await bestSellerRepoImpl.getBestSellerProducts();

        // Assert
        expect(response, isA<Success<List<BestSellerProductEntity>>>());
        expect((response as Success<List<BestSellerProductEntity>>).data, isNotEmpty);
      });

      test("Successfuly getting empty products", () async {
        // Arrange
        final BestSellerProductsResponseModel bestSellerProductsResponseModel =
            BestSellerProductsResponseModel(
              bestSeller: [],
              message: successMessage,
            );

        when(
          () => mockBestSellerRemoteDataSourceContract.getBestSellerProducts(),
        ).thenAnswer(
          (_) async => Success<BestSellerProductsResponseModel>(
            data: bestSellerProductsResponseModel,
          ),
        );

        // Act
        final response = await bestSellerRepoImpl.getBestSellerProducts();

        // Assert
        expect(response, isA<Success<List<BestSellerProductEntity>>>());
        expect((response as Success<List<BestSellerProductEntity>>).data, isEmpty);
      });

      test("Failed to get products", () async {

        // Arrange
        when(
          () => mockBestSellerRemoteDataSourceContract.getBestSellerProducts(),
        ).thenAnswer(
          (_) async => Error<BestSellerProductsResponseModel>(
            exception: Exception(errorMessage)
          ),
        );

        // Act
        final response = await bestSellerRepoImpl.getBestSellerProducts();

        // Assert
        expect(response, isA<Error<List<BestSellerProductEntity>>>());
        expect((response as Error<List<BestSellerProductEntity>>).exception.toString(), "Exception: $errorMessage");
      });
    });
  });
}
