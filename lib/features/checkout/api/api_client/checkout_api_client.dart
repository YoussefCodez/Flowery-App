import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/data/models/responses/create_cash_order_response.dart';
import 'package:flowery/features/checkout/data/models/responses/create_credit_order_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_api_client.g.dart';

@injectable
@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) = _CheckoutApiClient;

  @POST(AppEndPoints.checkoutSession)
  Future<CreateCreditOrderResponse> createCreditOrder();

  @POST(AppEndPoints.createCashOrder)
  Future<CreateCashOrderResponse> createCashOrder(@Body() CreateCashOrderRequest body);
}
