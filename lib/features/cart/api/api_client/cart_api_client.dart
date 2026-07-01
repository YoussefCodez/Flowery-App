import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/cart/data/models/requests/cart_request_model.dart';
import 'package:flowery/features/cart/data/models/responses/cart_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_client.g.dart';

@injectable
@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  @GET(AppEndPoints.cart)
  Future<CartResponseModel> getUserCartProducts();

  @DELETE("${AppEndPoints.cart}/{id}")
  Future<CartResponseModel> deleteSpecificItem(@Path("id") String productId);

  @PUT("${AppEndPoints.cart}/{id}")
  Future<CartResponseModel> updateCartProductQuantity(@Path("id") String productId ,@Body() CartRequestModel body);

  @POST(AppEndPoints.cart)
  Future<CartResponseModel> addToCart(@Body() CartRequestModel body);
}
