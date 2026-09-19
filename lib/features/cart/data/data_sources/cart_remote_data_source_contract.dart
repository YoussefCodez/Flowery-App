import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/data/models/responses/cart_response_model.dart';

abstract interface class CartRemoteDataSourceContract {
  Future<Result<CartResponseModel>> getUserCartProducts();

  Future<Result<CartResponseModel>> deleteSpecificItem(String cartItemId);

  Future<Result<CartResponseModel>> updateCartProductQuantity(
    String cartItemId,
    int quantity,
  );

  Future<Result<CartResponseModel>> addToCart(String cartItemId, int quantity);
}
