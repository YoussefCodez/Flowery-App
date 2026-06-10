import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class BestSellerProductEntity extends Equatable {
  final String imgCover;
  final String title;
  final String description;
  final int price;
  final int priceAfterDiscount;
  final int discount;
  final int quantity;
  final int sold;
  final List<String> images;
  final String id;
  const BestSellerProductEntity({
    required this.title,
    required this.description,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.quantity,
    required this.sold,
    required this.images, 
    required this.id,
  });

  @override
  List<Object?> get props => [
    imgCover,
    title,
    description,
    price,
    priceAfterDiscount,
    discount,
    quantity,
    sold,
    images,
    images,
    id
  ];
}
