import 'package:equatable/equatable.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';

class CartState extends Equatable {
  final CartEntity? cart;
  final bool isLoading;

  final bool isDeletingCartItem;
  final bool isUpdatingCartItem;
  final bool isAddingToCart;
  final bool isAddedSuccessfully;
  final String itemId;
  final String? errorMessage;

  const CartState({
    this.cart,
    this.isLoading = false,
    this.isDeletingCartItem = false,
    this.isUpdatingCartItem = false,
    this.isAddingToCart = false,
    this.itemId = '',
    this.errorMessage,
    this.isAddedSuccessfully = false,
  });

  CartState copyWith({
    CartEntity? cart,
    bool? isLoading,
    bool? isDeletingCartItem,
    bool? isUpdatingCartItem,
    bool? isAddingToCart,
    bool? isAddedSuccessfully,
    String? itemId,
    String? errorMessage,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      isDeletingCartItem: isDeletingCartItem ?? this.isDeletingCartItem,
      isUpdatingCartItem: isUpdatingCartItem ?? this.isUpdatingCartItem,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      itemId: itemId ?? this.itemId,
      errorMessage: errorMessage,
      isAddedSuccessfully: isAddedSuccessfully ?? this.isAddedSuccessfully,
    );
  }

  @override
  List<Object?> get props => [
    cart,
    isLoading,
    isDeletingCartItem,
    isUpdatingCartItem,
    isAddingToCart,
    itemId,
    errorMessage,
    isAddedSuccessfully,
  ];
}
