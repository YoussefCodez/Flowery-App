import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/search/api/search_api_client.dart';
import 'package:flowery/features/search/data/model/product_model.dart';
import 'package:flowery/features/search/data/model/search_response_model.dart';
import 'package:flowery/features/search/data/search_remote_data/search_remote_data_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_remote_data_impl_test.mocks.dart';

@GenerateMocks([SearchApiClient])
void main() {
  late SearchRemoteDataSourceImpl dataSource;
  late MockSearchApiClient mockSearchApiClient;

  setUp(() {
    mockSearchApiClient = MockSearchApiClient();
    dataSource = SearchRemoteDataSourceImpl(mockSearchApiClient);
  });

  group("searchProducts", () {
    test('Success', () async {
      // Arrange
      final tSearchResponse = SearchResponseModel(
        products: [Product(id: '1', title: 'Rose', price: 150)],
      );

      when(
        mockSearchApiClient.searchProducts('rose'),
      ).thenAnswer((_) async => tSearchResponse);

      // Act
      final result = await dataSource.searchProducts(search: 'rose');

      // Assert
      expect(result, isA<Success<List<Product>>>());
      expect((result as Success<List<Product>>).data, isNotEmpty);
      expect((result).data?[0].id, '1');
    });

    test('Error Dio Exception', () async {
      // Arrange
      final tDioException = DioException(
        requestOptions: RequestOptions(path: '/home'),
        type: DioExceptionType.connectionError,
      );
      when(mockSearchApiClient.searchProducts('rose')).thenThrow(tDioException);

      // Act
      final result = await dataSource.searchProducts(search: 'rose');

      // Assert
      expect(result, isA<Error>());
      expect((result as Error).exception, isA<DioException>());
    });

    test("Error Exception", () async {
      when(
        mockSearchApiClient.searchProducts('rose'),
      ).thenThrow(Exception('network error'));

      final result = await dataSource.searchProducts(search: 'rose');

      expect(result, isA<Error>());
      expect((result as Error).exception, isA<Exception>());
    });

    test("Error Timeout", () async {
      when(
        mockSearchApiClient.searchProducts('rose'),
      ).thenThrow(TimeoutException('connection timed out'));

      final result = await dataSource.searchProducts(search: 'rose');

      expect(result, isA<Error>());
      expect((result as Error).exception, isA<TimeoutException>());
    });
  });
}
