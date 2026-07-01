import 'package:flowery/core/const/best_seller_values.dart';
import 'package:flowery/features/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_product_model.g.dart';

@JsonSerializable()
class BestSellerProduct {
  @JsonKey(name: BestSellerValues.privateId)
  String? id;
  @JsonKey(name: BestSellerValues.title)
  String? title;
  @JsonKey(name: BestSellerValues.slug)
  String? slug;
  @JsonKey(name: BestSellerValues.description)
  String? description;
  @JsonKey(name: BestSellerValues.imgCover)
  String? imgCover;
  @JsonKey(name: BestSellerValues.images)
  List<String>? images;
  @JsonKey(name: BestSellerValues.price)
  int? price;
  @JsonKey(name: BestSellerValues.priceAfterDiscount)
  int? priceAfterDiscount;
  @JsonKey(name: BestSellerValues.discount)
  int? discount;
  @JsonKey(name: BestSellerValues.rateAvg)
  int? rateAvg;
  @JsonKey(name: BestSellerValues.rateCount)
  int? rateCount;
  @JsonKey(name: BestSellerValues.sold)
  int? sold;
  @JsonKey(name: BestSellerValues.quantity)
  int? quantity;
  @JsonKey(name: BestSellerValues.category)
  String? category;
  @JsonKey(name: BestSellerValues.occasion)
  String? occasion;
  @JsonKey(name: BestSellerValues.isSuperAdmin)
  bool? isSuperAdmin;
  @JsonKey(name: BestSellerValues.createdAt)
  DateTime? createdAt;
  @JsonKey(name: BestSellerValues.updatedAt)
  DateTime? updatedAt;
  @JsonKey(name: BestSellerValues.v)
  int? v;
  @JsonKey(name: BestSellerValues.id)
  String? bestSellerId;

  BestSellerProduct({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.rateAvg,
    required this.rateCount,
    this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.bestSellerId,
  });

  factory BestSellerProduct.fromJson(Map<String, dynamic> json) =>
      _$BestSellerProductFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerProductToJson(this);

  BestSellerProductEntity toDomain() {
    return BestSellerProductEntity(
      title: title ?? "",
      description: description ?? "",
      imgCover: imgCover ?? "",
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      discount: discount ?? 0,
      quantity: quantity ?? 0,
      sold: sold ?? 0,
      images: images ?? [],
    );
  }
}
