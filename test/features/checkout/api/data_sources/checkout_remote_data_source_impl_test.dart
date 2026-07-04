import 'package:dio/dio.dart';
import 'package:flowery/features/checkout/api/data_sources/checkout_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/data/models/responses/create_cash_order_response.dart';
import 'package:flowery/features/checkout/data/models/responses/create_credit_order_response.dart';

class MockCheckoutApiClient extends Mock implements CheckoutApiClient {}

void main() {
  late MockCheckoutApiClient apiClient;
  late CheckoutRemoteDataSourceImpl dataSource;
  final ShippingAddress shippingAddress = ShippingAddress(
    street: 'test',
    phone: 'test',
    city: 'test',
    lat: 'test',
    long: 'test',
  );
  setUp(() {
    apiClient = MockCheckoutApiClient();
    dataSource = CheckoutRemoteDataSourceImpl(apiClient);
  });

  group('checkOutSession', () {
    test('returns Success when API succeeds', () async {
      final response = CreateCreditOrderResponse();

      when(() => apiClient.createCreditOrder())
          .thenAnswer((_) async => response);

      final result = await dataSource.checkOutSession();

      expect(result, isA<Success<CreateCreditOrderResponse>>());
      verify(() => apiClient.createCreditOrder()).called(1);
    });

    test('returns Error when DioException thrown', () async {
      when(() => apiClient.createCreditOrder())
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.checkOutSession();

      expect(result, isA<Error<CreateCreditOrderResponse>>());
      verify(() => apiClient.createCreditOrder()).called(1);
    });
  });

  group('createCashOrder', () {
    test('returns Success when API succeeds', () async {
      final request = CreateCashOrderRequest(shippingAddress: shippingAddress);
      final response = CreateCashOrderResponse();

      when(() => apiClient.createCashOrder(request))
          .thenAnswer((_) async => response);

      final result = await dataSource.createCashOrder(request);

      expect(result, isA<Success<CreateCashOrderResponse>>());
      verify(() => apiClient.createCashOrder(request)).called(1);
    });

    test('returns Error when DioException thrown', () async {
      final request = CreateCashOrderRequest(shippingAddress: shippingAddress);

      when(() => apiClient.createCashOrder(request))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.createCashOrder(request);

      expect(result, isA<Error<CreateCashOrderResponse>>());
      verify(() => apiClient.createCashOrder(request)).called(1);
    });
  });
}