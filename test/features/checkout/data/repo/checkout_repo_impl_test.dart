import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/data/models/responses/create_cash_order_response.dart';
import 'package:flowery/features/checkout/data/models/responses/create_credit_order_response.dart';
import 'package:flowery/features/checkout/data/repo/checkout_repo_impl.dart';
import 'package:flowery/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';

class MockCheckoutRemoteDataSource extends Mock
    implements CheckoutRemoteDataSourceContract {}

void main() {
  late MockCheckoutRemoteDataSource dataSource;
  late CheckoutRepoImpl repo;
  final ShippingAddress shippingAddress = ShippingAddress(
    street: 'test',
    phone: 'test',
    city: 'test',
    lat: 'test',
    long: 'test',
  );
  setUp(() {
    dataSource = MockCheckoutRemoteDataSource();
    repo = CheckoutRepoImpl(dataSource);
  });

  group('CheckoutRepoImpl - createCreditOrder', () {
    test('returns Success when dataSource returns Success', () async {
      final mockResponse = CreateCreditOrderResponse(
        session: null, // keep simple; assumes extension handles null safely
      );

      when(
        () => dataSource.checkOutSession(),
      ).thenAnswer((_) async => Success(data: mockResponse));

      final result = await repo.createCreditOrder();

      expect(result, isA<Success<CreditOrderEntity>>());
      verify(() => dataSource.checkOutSession()).called(1);
    });

    test('returns Error when dataSource returns Error', () async {
      final exception = Exception('error');

      when(
        () => dataSource.checkOutSession(),
      ).thenAnswer((_) async => Error(exception: exception));

      final result = await repo.createCreditOrder();

      expect(result, isA<Error<CreditOrderEntity>>());
      verify(() => dataSource.checkOutSession()).called(1);
    });
  });

  group('CheckoutRepoImpl - createCashOrder', () {
    test('returns Success when cash order succeeds', () async {
      final request = CreateCashOrderRequest(shippingAddress: shippingAddress);

      final mockResponse = CreateCashOrderResponse();

      when(
        () => dataSource.createCashOrder(request),
      ).thenAnswer((_) async => Success(data: mockResponse));

      final result = await repo.createCashOrder(request);

      expect(result, isA<Success<CashOrderEntity>>());
      verify(() => dataSource.createCashOrder(request)).called(1);
    });

    test('returns Error when cash order fails', () async {
      final request = CreateCashOrderRequest(shippingAddress: shippingAddress);
      final exception = Exception('error');

      when(
        () => dataSource.createCashOrder(request),
      ).thenAnswer((_) async => Error(exception: exception));

      final result = await repo.createCashOrder(request);

      expect(result, isA<Error<CashOrderEntity>>());
      verify(() => dataSource.createCashOrder(request)).called(1);
    });
  });
}
