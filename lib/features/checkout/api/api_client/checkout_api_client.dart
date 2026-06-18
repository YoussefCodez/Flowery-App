import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/checkout/data/models/checkout_session_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_api_client.g.dart';

@injectable
@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) = _CheckoutApiClient;

  @POST(AppEndPoints.checkoutSession)
  Future<CheckoutSessionResponseModel> checkOutSession();
}
