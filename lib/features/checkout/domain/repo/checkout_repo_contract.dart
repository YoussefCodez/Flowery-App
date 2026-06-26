import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';

abstract interface class CheckoutRepoContract {
  Future<Result<CreditOrderEntity>> createCreditOrder();
  Future<Result<CashOrderEntity>> createCashOrder(
    CreateCashOrderRequest request,
  );
}
