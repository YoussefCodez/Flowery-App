// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
  imgCover: json['imgCover'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  price: (json['price'] as num?)?.toInt() ?? 0,
  priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt() ?? 0,
  discount: (json['discount'] as num?)?.toInt() ?? 0,
  rateAvg: (json['rateAvg'] as num?)?.toInt() ?? 0,
  rateCount: (json['rateCount'] as num?)?.toInt() ?? 0,
  sold: (json['sold'] as num?)?.toInt() ?? 0,
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  category: json['category'] as String?,
  occasion: json['occasion'] as String?,
  isSuperAdmin: json['isSuperAdmin'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  v: (json['__v'] as num?)?.toInt(),
  favoriteId: json['favoriteId'],
  isInWishlist: json['isInWishlist'] as bool?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'imgCover': instance.imgCover,
  'images': instance.images,
  'price': instance.price,
  'priceAfterDiscount': instance.priceAfterDiscount,
  'discount': instance.discount,
  'rateAvg': instance.rateAvg,
  'rateCount': instance.rateCount,
  'sold': instance.sold,
  'quantity': instance.quantity,
  'category': instance.category,
  'occasion': instance.occasion,
  'isSuperAdmin': instance.isSuperAdmin,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  '__v': instance.v,
  'favoriteId': instance.favoriteId,
  'isInWishlist': instance.isInWishlist,
};
