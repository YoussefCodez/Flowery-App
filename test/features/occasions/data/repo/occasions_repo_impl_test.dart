import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/data/data_sources/occasions_data_sources_contract.dart';
import 'package:flowery/features/occasions/data/models/response/meta_data_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_products_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasions_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/product_model.dart';
import 'package:flowery/features/occasions/data/repo/occasions_repo_impl.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOccasionsDataSourcesContract extends Mock
    implements OccasionsDataSourcesContract {}

void main() {
  late OccasionsRepoImpl occasionsRepoImpl;
  late MockOccasionsDataSourcesContract mockOccasionsDataSourcesContract;
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

  final successOccasionsData = OccasionsResponseModel(
    message: successMessage,
    metadata: metaData,
    occasions: occasions,
  );

  final successOccasionsDataWithEmptyOccsions = OccasionsResponseModel(
    message: successMessage,
    metadata: metaData,
    occasions: [],
  );

  final successProductsData = OccasionProductsResponseModel(
    message: successMessage,
    metadata: metaData,
    products: products,
  );

  final successProductsDataWithEmptyOccsions = OccasionProductsResponseModel(
    message: successMessage,
    metadata: metaData,
    products: [],
  );

  setUpAll(() {
    mockOccasionsDataSourcesContract = MockOccasionsDataSourcesContract();
    occasionsRepoImpl = OccasionsRepoImpl(
      dataSources: mockOccasionsDataSourcesContract,
    );
  });

  group('Testing Repo', () {
    group('Testing occasions', () {
      test("Successfuly getting the occasions", () async {
        // Arrange
        when(() => mockOccasionsDataSourcesContract.getOccasions()).thenAnswer(
          (_) async =>
              Success<OccasionsResponseModel>(data: successOccasionsData),
        );

        // Act
        final response = await occasionsRepoImpl.getOccasions();

        // Assert
        expect(response, isA<Success<List<OccasionEntity>>>());
        expect((response as Success<List<OccasionEntity>>).data, isNotEmpty);
      });

      test("Successfuly getting empty occasions", () async {
        // Arrange
        when(() => mockOccasionsDataSourcesContract.getOccasions()).thenAnswer(
          (_) async => Success<OccasionsResponseModel>(
            data: successOccasionsDataWithEmptyOccsions,
          ),
        );

        // Act
        final response = await occasionsRepoImpl.getOccasions();

        // Assert
        expect(response, isA<Success<List<OccasionEntity>>>());
        expect((response as Success<List<OccasionEntity>>).data, isEmpty);
      });

      test("Failed to get occasions", () async {
        // Arrange
        when(() => mockOccasionsDataSourcesContract.getOccasions()).thenAnswer(
          (_) async =>
              Error<OccasionsResponseModel>(exception: Exception(errorMessage)),
        );

        // Act
        final response = await occasionsRepoImpl.getOccasions();

        // Assert
        expect(response, isA<Error<List<OccasionEntity>>>());
        expect(
          (response as Error<List<OccasionEntity>>).exception.toString(),
          Exception(errorMessage).toString(),
        );
      });
    });
    group('Testing products', () {
      test("Successfuly getting the products", () async {
        // Arrange
        when(
          () => mockOccasionsDataSourcesContract.getProductsOfSpecificOccasion(
            occasions[0].id!,
          ),
        ).thenAnswer(
          (_) async =>
              Success<OccasionProductsResponseModel>(data: successProductsData),
        );

        // Act
        final response = await occasionsRepoImpl.getProductsOfSpecificOccasion(
          occasions[0].id!,
        );

        // Assert
        expect(response, isA<Success<List<ProductEntity>>>());
        expect((response as Success<List<ProductEntity>>).data, isNotEmpty);
      });

      test("Successfuly getting empty products", () async {
        // Arrange
        when(
          () => mockOccasionsDataSourcesContract.getProductsOfSpecificOccasion(
            occasions[0].id!,
          ),
        ).thenAnswer(
          (_) async => Success<OccasionProductsResponseModel>(
            data: successProductsDataWithEmptyOccsions,
          ),
        );

        // Act
        final response = await occasionsRepoImpl.getProductsOfSpecificOccasion(
          occasions[0].id!,
        );

        // Assert
        expect(response, isA<Success<List<ProductEntity>>>());
        expect((response as Success<List<ProductEntity>>).data, isEmpty);
      });

      test("Failed to get products", () async {
        // Arrange
        when(
          () => mockOccasionsDataSourcesContract.getProductsOfSpecificOccasion(
            occasions[0].id!,
          ),
        ).thenAnswer(
          (_) async => Error<OccasionProductsResponseModel>(
            exception: Exception(errorMessage),
          ),
        );

        // Act
        final response = await occasionsRepoImpl.getProductsOfSpecificOccasion(
          occasions[0].id!,
        );

        // Assert
        expect(response, isA<Error<List<ProductEntity>>>());
        expect(
          (response as Error<List<ProductEntity>>).exception.toString(),
          Exception(errorMessage).toString(),
        );
      });
    });
  });
}
