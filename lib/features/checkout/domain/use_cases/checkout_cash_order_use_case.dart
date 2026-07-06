import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flowery/features/checkout/domain/repo/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCashOrderUseCase {
  final CheckoutRepoContract repo;
  CheckoutCashOrderUseCase(this.repo);

  Future<Result<CashOrderEntity>> call(CreateCashOrderRequest request) =>
      repo.createCashOrder(request);
}
