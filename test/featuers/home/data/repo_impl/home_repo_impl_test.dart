import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/data_source/home_remote_data_source_contract.dart';
import 'package:flowery/featuers/home/data/models/response_model/best_seller_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/category_model.dart'
    as model;
import 'package:flowery/featuers/home/data/models/response_model/home_response_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/occasion_model.dart';
import 'package:flowery/featuers/home/data/repo_impl/home_repo_impl.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSourceContract])
void main() {
  late MockHomeRemoteDataSourceContract mockHomeRemoteDataSourceContract;
  late HomeRepoImpl homeRepoImpl;

  setUp(() {
    provideDummy<Result<HomeResponseModel>>(
      Success<HomeResponseModel>(data: HomeResponseModel()),
    );

    mockHomeRemoteDataSourceContract = MockHomeRemoteDataSourceContract();
    homeRepoImpl = HomeRepoImpl(mockHomeRemoteDataSourceContract);
  });

  group("BestSeller", () {
    test("Success With Data", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(
        bestSeller: [
          BestSeller(id: '1', title: 'Rose', price: 150.0),
          BestSeller(id: '1', title: 'Rose', price: 150.0),
          BestSeller(id: '1', title: 'Rose', price: 150.0),
          BestSeller(id: '1', title: 'Rose', price: 150.0),
        ],
      );

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getBestSeller();

      expect(result, isA<Success<List<BestSellerEntity>>>());
      expect((result as Success<List<BestSellerEntity>>).data, isNotEmpty);
      expect((result).data?.length, 4);
      expect((result).data?[0].id, '1');
      expect((result).data?[0].title, 'Rose');
      expect((result).data?[0].price, 150.0);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Success With  EmptyData", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(bestSeller: [
          
        ],
      );

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getBestSeller();

      expect(result, isA<Success<List<BestSellerEntity>>>());
      expect((result as Success<List<BestSellerEntity>>).data, isEmpty);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Error Case", () async {
      // Arrange
      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Error<HomeResponseModel>(exception: Exception()),
      );

      // Act
      final result = await homeRepoImpl.getBestSeller();

      // Assert
      expect(result, isA<Error<List<BestSellerEntity>>>());
      expect((result as Error<List<BestSellerEntity>>).exception, isNotNull);
    });
  });

  group("Occasion", () {
    test("Success With Data", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(
        occasions: [Occasion(id: '1', name: "test", isSuperAdmin: true)],
      );

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getOccasion();

      expect(result, isA<Success<List<OccasionEntity>>>());
      expect((result as Success<List<OccasionEntity>>).data, isNotEmpty);
      expect((result).data?.length, 1);
      expect((result).data?[0].id, '1');
      expect((result).data?[0].name, 'test');
      expect((result).data?[0].isSuperAdmin, true);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Success With  EmptyData", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(occasions: [
          
        ],
      );

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getOccasion();

      expect(result, isA<Success<List<OccasionEntity>>>());
      expect((result as Success<List<OccasionEntity>>).data, isEmpty);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Error Case", () async {
      // Arrange
      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Error<HomeResponseModel>(exception: Exception()),
      );

      // Act
      final result = await homeRepoImpl.getOccasion();

      // Assert
      expect(result, isA<Error<List<OccasionEntity>>>());
      expect((result as Error<List<OccasionEntity>>).exception, isNotNull);
    });
  });

  group("Category", () {
    test("Success With Data", () async {
      final fakeResponse = HomeResponseModel(
        categories: [model.Category(id: "1", name: "test", isSuperAdmin: true)],
      );
      when(
        mockHomeRemoteDataSourceContract.getHomeData(),
      ).thenAnswer((_) async => Success<HomeResponseModel>(data: fakeResponse));
      final result = await homeRepoImpl.getCategory();

      expect(result, isA<Success<List<CategoryEntity>>>());
      expect((result as Success<List<CategoryEntity>>).data, isNotEmpty);
      expect((result).data?.length, 1);
      expect((result).data?[0].id, '1');
      expect((result).data?[0].name, 'test');
      expect((result).data?[0].isSuperAdmin, true);
    });
    test("Success With  EmptyData", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(categories: []);

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getCategory();

      expect(result, isA<Success<List<CategoryEntity>>>());
      expect((result as Success<List<CategoryEntity>>).data, isEmpty);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Error Case", () async {
      // Arrange
      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Error<HomeResponseModel>(exception: Exception()),
      );

      // Act
      final result = await homeRepoImpl.getCategory();

      // Assert
      expect(result, isA<Error<List<CategoryEntity>>>());
      expect((result as Error<List<CategoryEntity>>).exception, isNotNull);
    });
  });
}
