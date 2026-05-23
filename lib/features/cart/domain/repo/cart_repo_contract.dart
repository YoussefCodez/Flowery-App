import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';

abstract interface class CartRepoContract {
  Future<Result<CartEntity>> getUserCartProducts();

  Future<Result<CartEntity>> deleteSpecificItem(String cartItemId);

  Future<Result<CartEntity>> updateCartProductQuantity(String cartItemId, int quantity);
}