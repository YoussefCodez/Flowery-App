// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseModel _$ProductResponseModelFromJson(
  Map<String, dynamic> json,
) => ProductResponseModel(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : MetadataModel.fromJson(json['metadata'] as Map<String, dynamic>),
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductResponseModelToJson(
  ProductResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'products': instance.products,
};
