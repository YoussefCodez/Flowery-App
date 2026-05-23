import 'package:equatable/equatable.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter/material.dart';

@immutable
class CartBaseState extends Equatable {
  final bool isLoadingCart;
  final CartEntity cart;
  final String errorMessage;
  final int deliveryFee;
  const CartBaseState({
    this.isLoadingCart = false,
    this.cart = const CartEntity(
      numberOfCartItems: 0,
      totalPriceAfterDiscount: 0,
      cartItems: [],
      discount: 0,
      totalPriceBeforeDiscount: 0,
    ),
    this.errorMessage = "",
    this.deliveryFee = 50,
  });

  CartBaseState copyWith({
    bool? isLoadingCart,
    CartEntity? cart,
    String? errorMessage,
    int? deliveryFee,
  }) => CartBaseState(
    isLoadingCart: isLoadingCart ?? this.isLoadingCart,
    cart: cart ?? this.cart,
    errorMessage: errorMessage ?? this.errorMessage,
    deliveryFee: deliveryFee ?? this.deliveryFee,
  );
  @override
  List<Object?> get props => [isLoadingCart, cart, errorMessage, deliveryFee];
}
