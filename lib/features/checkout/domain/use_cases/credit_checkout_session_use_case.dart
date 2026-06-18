import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/domain/entities/checkout_entity.dart';
import 'package:flowery/features/checkout/domain/repo/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreditCheckoutSessionUseCase {
  final CheckoutRepoContract repo;
  CreditCheckoutSessionUseCase(this.repo);

  Future<Result<CheckoutEntity>> call() => repo.checkOutSession();
}
