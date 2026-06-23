import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/product_entity.dart';
part 'product_model.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "imgCover")
  String? imgCover;
  @JsonKey(name: "images")
  List<String>? images;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "priceAfterDiscount")
  double? priceAfterDiscount;
  @JsonKey(name: "discount")
  double? discount;
  @JsonKey(name: "rateAvg")
  double? rateAvg;
  @JsonKey(name: "rateCount")
  double? rateCount;
  @JsonKey(name: "sold")
  int? sold;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "occasion")
  String? occasion;
  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "id")
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

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  ProductEntity toDomain() => ProductEntity(
    id: id ?? '',
    title: title ?? '',
    slug: slug ?? '',
    description: description ?? '',
    imgCover: imgCover ?? '',
    images: images ?? [],            // ✅ was: images??''  (String is wrong type)
    price: price ?? 0.0,
    priceAfterDiscount: priceAfterDiscount ?? 0.0,
    discount: discount ?? 0.0,
    rateAvg: rateAvg ?? 0.0,
    rateCount: rateCount ?? 0.0,
    sold: sold ?? 0,
    quantity: quantity ?? 0,
    category: category ?? '',
    occasion: occasion ?? '',
    isSuperAdmin: isSuperAdmin ?? false,
    createdAt: createdAt ?? DateTime.now(),   // ✅ was: createdAt  (nullable, not safe)
    updatedAt: updatedAt ?? DateTime.now(),   // ✅ was: updatedAt  (nullable, not safe)
    productId: productId ?? '',      // ✅ was: productId??0  (int is wrong type)
  );
}