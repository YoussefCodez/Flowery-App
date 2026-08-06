import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/data_source/home_remote_data_source_contract.dart';
import 'package:flowery/featuers/home/data/models/response_model/best_seller_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/category_model.dart'
    as model;
import 'package:flowery/featuers/home/data/models/response_model/home_response_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/occasion_model.dart';
import 'package:flowery/featuers/home/data/repo_impl/home_repo_impl.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/home_entity.dart';
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

  group("getHomeData", () {
    test("Success With Data", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(
        categories: [model.Category(id: "1", name: "test", isSuperAdmin: true)],
        bestSeller: [
          BestSeller(id: '1', title: 'Rose', price: 150.0),
        ],
        occasions: [Occasion(id: '1', name: "test", isSuperAdmin: true)],
      );

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getHomeData();

      expect(result, isA<Success<HomeEntity>>());
      final data = (result as Success<HomeEntity>).data!;

      expect(data.categories, isNotEmpty);
      expect(data.categories?[0].id, '1');
      expect(data.categories?[0].name, 'test');
      expect(data.categories?[0].isSuperAdmin, true);

      expect(data.bestSeller, isNotEmpty);
      expect(data.bestSeller?[0].id, '1');
      expect(data.bestSeller?[0].title, 'Rose');
      expect(data.bestSeller?[0].price, 150.0);

      expect(data.occasions, isNotEmpty);
      expect(data.occasions?[0].id, '1');
      expect(data.occasions?[0].name, 'test');
      expect(data.occasions?[0].isSuperAdmin, true);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Success With EmptyData", () async {
      // Arrange
      final fakeHomeResponse = HomeResponseModel(
        categories: [],
        bestSeller: [],
        occasions: [],
      );

      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Success<HomeResponseModel>(data: fakeHomeResponse),
      );

      final result = await homeRepoImpl.getHomeData();

      expect(result, isA<Success<HomeEntity>>());
      final data = (result as Success<HomeEntity>).data!;

      expect(data.categories, isEmpty);
      expect(data.bestSeller, isEmpty);
      expect(data.occasions, isEmpty);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });

    test("Error Case", () async {
      // Arrange
      when(mockHomeRemoteDataSourceContract.getHomeData()).thenAnswer(
        (_) async => Error<HomeResponseModel>(exception: Exception()),
      );

      // Act
      final result = await homeRepoImpl.getHomeData();

      // Assert
      expect(result, isA<Error<HomeEntity>>());
      expect((result as Error<HomeEntity>).exception, isNotNull);

      verify(mockHomeRemoteDataSourceContract.getHomeData()).called(1);
    });
  });
}
