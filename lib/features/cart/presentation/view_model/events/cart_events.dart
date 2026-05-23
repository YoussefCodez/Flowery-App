sealed class CartEvents {}

class GetUserCartProductsEvent extends CartEvents {}

class DeleteSpecificCartItemEvent extends CartEvents {}

class UpdateSpecificCartItemEvent extends CartEvents {}

class AddToCartEvent extends CartEvents {}
