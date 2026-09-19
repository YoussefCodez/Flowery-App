import 'package:equatable/equatable.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';

class CartState extends Equatable {
  final CartEntity? cart;
  final bool isLoadingCart;
  final bool isDeletingCartItem;
  final bool isDeletingCart;
  final bool isUpdatingCartItem;
  final bool isAddingToCart;
  final bool isAddedSuccessfully;
  final String itemId;
  final String? errorMessage;

  const CartState({
    this.cart,
    this.isLoadingCart = false,
    this.isDeletingCartItem = false,
    this.isUpdatingCartItem = false,
    this.isAddingToCart = false,
    this.itemId = '',
    this.errorMessage,
    this.isAddedSuccessfully = false,
    this.isDeletingCart = false,
  });

  CartState copyWith({
    Value<CartEntity?>? cart,
    bool? isLoadingCart,
    bool? isDeletingCartItem,
    bool? isDeletingCart,
    bool? isUpdatingCartItem,
    bool? isAddingToCart,
    bool? isAddedSuccessfully,
    String? itemId,
    String? errorMessage,
  }) {
    return CartState(
      cart: cart != null ? cart.value : this.cart,
      isLoadingCart: isLoadingCart ?? this.isLoadingCart,
      isDeletingCartItem: isDeletingCartItem ?? this.isDeletingCartItem,
      isUpdatingCartItem: isUpdatingCartItem ?? this.isUpdatingCartItem,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      itemId: itemId ?? this.itemId,
      errorMessage: errorMessage,
      isAddedSuccessfully: isAddedSuccessfully ?? this.isAddedSuccessfully,
      isDeletingCart: isDeletingCart ?? this.isDeletingCart,
    );
  }

  @override
  List<Object?> get props => [
    cart,
    isLoadingCart,
    isDeletingCartItem,
    isUpdatingCartItem,
    isAddingToCart,
    itemId,
    errorMessage,
    isAddedSuccessfully,
  ];
}

class Value<T> {
  final T? value;
  const Value(this.value);
}
