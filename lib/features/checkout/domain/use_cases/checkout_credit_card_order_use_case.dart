import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';
import 'package:flowery/features/checkout/domain/repo/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCreditCardOrderUseCase {
  final CheckoutRepoContract repo;
  CheckoutCreditCardOrderUseCase(this.repo);

  Future<Result<CreditOrderEntity>> call() => repo.createCreditOrder();
}
