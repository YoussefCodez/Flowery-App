import 'package:equatable/equatable.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';

class CartState extends Equatable {
  final CartEntity? cart;
  final bool isLoading;
  final String? errorMessage;

  const CartState({
    this.cart,
    this.isLoading = false,
    this.errorMessage,
  });

  CartState copyWith({
    CartEntity? cart,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        cart,
        isLoading,
        errorMessage,
      ];
}