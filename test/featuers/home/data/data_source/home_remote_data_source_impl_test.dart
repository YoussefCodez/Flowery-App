import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/api/home_api_client/home_api_client.dart';
import 'package:flowery/featuers/home/data/data_source/home_remote_data_source_impl.dart';
import 'package:flowery/featuers/home/data/models/response_model/home_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiClient])
void main() {
  late MockHomeApiClient mockHomeApiClient;
  late HomeRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHomeApiClient = MockHomeApiClient();
    dataSource = HomeRemoteDataSourceImpl(mockHomeApiClient);
  });
  final tHomeResponseModel = HomeResponseModel();
  group('HomeRemoteDataSourceImpl', () {
    test('Success', () async {
      // Arrange
      when(
        mockHomeApiClient.getHomeData(),
      ).thenAnswer((_) async => tHomeResponseModel);

      //Act
      final result = await dataSource.getHomeData();

      //Assert
      expect(result, isA<Success<HomeResponseModel>>());
      expect((result as Success).data, equals(tHomeResponseModel));

      verify(mockHomeApiClient.getHomeData()).called(1);
      verifyNoMoreInteractions(mockHomeApiClient);
    });

    test('Error Dio Exception', () async {
      final tDioException = DioException(
        requestOptions: RequestOptions(path: '/home'),
        type: DioExceptionType.connectionError,
      );

      // Arrange
      when(mockHomeApiClient.getHomeData()).thenThrow(tDioException);

      //Act
      final result = await dataSource.getHomeData();

      //Assert
      expect(result, isA<Error>());
      expect((result as Error).exception, isA<DioException>());
    });

    test('Error Exception', () async {
      // Arrange
      when(
        mockHomeApiClient.getHomeData(),
      ).thenThrow(Exception('network error'));

      //Act
      final result = await dataSource.getHomeData();

      //Assert
      expect(result, isA<Error>());
      expect((result as Error).exception, isA<Exception>());
    });

    test('Error TimeoutEception', () async {
      // Arrange
      when(
        mockHomeApiClient.getHomeData(),
      ).thenThrow(TimeoutException('connection timed out'));

      //Act
      final result = await dataSource.getHomeData();

      //Assert
      expect(result, isA<Error>());
      expect((result as Error).exception, isA<TimeoutException>());
    });
  });
}
