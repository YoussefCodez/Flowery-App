import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/domain/entities/checkout_entity.dart';

abstract interface class CheckoutRepoContract {
  Future<Result<CheckoutEntity>> checkOutSession();
}