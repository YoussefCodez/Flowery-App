import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ProductEntity extends Equatable {
  final String? productId;
  final String? title;
  final String? description;
  final String? imgCover;
  final int? price;

  const ProductEntity({
    required this.productId,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.price,
  });

  @override
  List<Object?> get props => [title, description, imgCover, price];
}
