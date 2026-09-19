import 'package:equatable/equatable.dart';
import 'package:flowery/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter/material.dart';

@immutable
class CartEntity extends Equatable {
  final int? numberOfCartItems;
  final int? discount;
  final int? totalPriceBeforeDiscount;
  final int? totalPriceAfterDiscount;
  final List<CartItemEntity>? cartItems;

  const CartEntity({
    required this.numberOfCartItems,
    required this.totalPriceAfterDiscount,
    required this.cartItems,
    required this.discount,
    required this.totalPriceBeforeDiscount,
  });

  @override
  List<Object?> get props => [
    numberOfCartItems,
    totalPriceAfterDiscount,
    cartItems,
    discount,
    totalPriceBeforeDiscount,
  ];
}
