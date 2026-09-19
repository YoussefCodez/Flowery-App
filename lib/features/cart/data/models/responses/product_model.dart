import 'package:flowery/core/const/cart_values.dart';
import 'package:flowery/features/cart/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: CartValues.id)
  String? id;

  @JsonKey(name: CartValues.title)
  String? title;

  @JsonKey(name: CartValues.slug)
  String? slug;

  @JsonKey(name: CartValues.description)
  String? description;

  @JsonKey(name: CartValues.imgCover)
  String? imgCover;

  @JsonKey(name: CartValues.images)
  List<String>? images;

  @JsonKey(name: CartValues.price)
  int? price;

  @JsonKey(name: CartValues.priceAfterDiscount)
  int? priceAfterDiscount;

  @JsonKey(name: CartValues.discount)
  int? discount;

  @JsonKey(name: CartValues.rateAvg)
  int? rateAvg;

  @JsonKey(name: CartValues.rateCount)
  int? rateCount;

  @JsonKey(name: CartValues.sold)
  int? sold;

  @JsonKey(name: CartValues.quantity)
  int? quantity;

  @JsonKey(name: CartValues.category)
  String? category;

  @JsonKey(name: CartValues.occasion)
  String? occasion;

  @JsonKey(name: CartValues.isSuperAdmin)
  bool? isSuperAdmin;

  @JsonKey(name: CartValues.createdAt)
  DateTime? createdAt;

  @JsonKey(name: CartValues.updatedAt)
  DateTime? updatedAt;

  @JsonKey(name: CartValues.version)
  int? v;

  @JsonKey(name: CartValues.productId)
  String? productId;

  Product({
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
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  ProductEntity toDomain() {
    return ProductEntity(
      productId: id,
      title: title,
      description: description,
      imgCover: imgCover,
      price: price,
    );
  }
}
