import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final num? discount;
  final num? rateAvg;
  final int? rateCount;
  final int? quantity;
  final String? category;

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.quantity,
    this.category,
  });

  @override
  List<Object?> get props => [id, title, slug, price, imgCover, category];
}
