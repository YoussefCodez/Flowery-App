// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasion_products_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionProductsResponseModel _$OccasionProductsResponseModelFromJson(
  Map<String, dynamic> json,
) => OccasionProductsResponseModel(
  message: json['message'] as String,
  metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  products: (json['products'] as List<dynamic>)
      .map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OccasionProductsResponseModelToJson(
  OccasionProductsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'products': instance.products,
};
