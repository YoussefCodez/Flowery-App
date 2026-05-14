// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_seller_products_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestSellerProductsResponseModel _$BestSellerProductsResponseModelFromJson(
  Map<String, dynamic> json,
) => BestSellerProductsResponseModel(
  message: json['message'] as String,
  bestSeller: (json['bestSeller'] as List<dynamic>)
      .map((e) => BestSellerProduct.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BestSellerProductsResponseModelToJson(
  BestSellerProductsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'bestSeller': instance.bestSeller,
};
