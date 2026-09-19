import 'package:equatable/equatable.dart';
import 'package:flowery/features/cart/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

@immutable
class CartItemEntity extends Equatable {
  final ProductEntity? product;
  final int? quantity;

  const CartItemEntity({
    required this.product,
    required this.quantity,
  });
  @override
  List<Object?> get props => [product, quantity];
}
