import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
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
  Future<CartResponseModel> deleteSpecificItem(@Path("id") String cartItemId);

  @PUT("${AppEndPoints.cart}/{id}")
  Future<CartResponseModel> updateCartProductQuantity(@Path("id") String cartItemId ,@Body() Map<String, int> body);

  @POST(AppEndPoints.cart)
  Future<CartResponseModel> addToCart(@Body() Map<String, dynamic> body);
}
