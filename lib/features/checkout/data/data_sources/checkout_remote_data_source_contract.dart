import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/data/models/responses/create_credit_order_response.dart';
import 'package:flowery/features/checkout/data/models/responses/create_cash_order_response.dart';

abstract interface class CheckoutRemoteDataSourceContract {
  Future<Result<CreateCreditOrderResponse>> checkOutSession();

  Future<Result<CreateCashOrderResponse>> createCashOrder(
    CreateCashOrderRequest request,
  );
}
