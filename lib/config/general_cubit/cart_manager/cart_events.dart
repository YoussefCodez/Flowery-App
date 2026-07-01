sealed class CartEvents {}

class GetUserCartProductsEvent extends CartEvents {}

class DeleteSpecificCartItemEvent extends CartEvents {
  final String productId;

  DeleteSpecificCartItemEvent({required this.productId});
}

class UpdateSpecificCartItemEvent extends CartEvents {
  final String productId;
  final int quantity;

  UpdateSpecificCartItemEvent({
    required this.productId,
    required this.quantity,
  });
}

class AddToCartEvent extends CartEvents {
  final String productId;
  final int quantity;

  AddToCartEvent({required this.productId, required this.quantity});
}
