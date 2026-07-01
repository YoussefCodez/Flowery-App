import 'package:flowery/core/const/occasions_values.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: OccasionsValues.id)
  String? id;
  @JsonKey(name: OccasionsValues.title)
  String? title;
  @JsonKey(name: OccasionsValues.slug)
  String? slug;
  @JsonKey(name: OccasionsValues.description)
  String? description;
  @JsonKey(name: OccasionsValues.imgCover)
  String? imgCover;
  @JsonKey(name: OccasionsValues.images)
  List<String>? images;
  @JsonKey(name: OccasionsValues.price, defaultValue: 0)
  int? price;
  @JsonKey(name: OccasionsValues.priceAfterDiscount, defaultValue: 0)
  int? priceAfterDiscount;
  @JsonKey(name: OccasionsValues.discount, defaultValue: 0)
  int? discount;
  @JsonKey(name: OccasionsValues.rateAvg, defaultValue: 0)
  int? rateAvg;
  @JsonKey(name: OccasionsValues.rateCount, defaultValue: 0)
  int? rateCount;
  @JsonKey(name: OccasionsValues.sold, defaultValue: 0)
  int? sold;
  @JsonKey(name: OccasionsValues.quantity, defaultValue: 0)
  int? quantity;
  @JsonKey(name: OccasionsValues.category)
  String? category;
  @JsonKey(name: OccasionsValues.occasion)
  String? occasion;
  @JsonKey(name: OccasionsValues.isSuperAdmin)
  bool? isSuperAdmin;
  @JsonKey(name: OccasionsValues.createdAt)
  DateTime? createdAt;
  @JsonKey(name: OccasionsValues.updatedAt)
  DateTime? updatedAt;
  @JsonKey(name: OccasionsValues.v)
  int? v;
  @JsonKey(name: OccasionsValues.favoriteId)
  dynamic favoriteId;
  @JsonKey(name: OccasionsValues.isInWishlist)
  bool? isInWishlist;

  Product({
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
    required this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.favoriteId,
    required this.isInWishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  ProductEntity toDomain() {
    return ProductEntity(
      imgCover: imgCover ?? "",
      title: title ?? "",
      description: description ?? "",
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      discount: discount ?? 0,
      quantity: quantity ?? 0,
      sold: sold ?? 0,
      images: images ?? []
    );
  }
}
