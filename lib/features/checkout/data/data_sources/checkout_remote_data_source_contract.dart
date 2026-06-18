import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/models/checkout_session_response_model.dart';

abstract interface class CheckoutRemoteDataSourceContract {
  Future<Result<CheckoutSessionResponseModel>> checkOutSession();
}
