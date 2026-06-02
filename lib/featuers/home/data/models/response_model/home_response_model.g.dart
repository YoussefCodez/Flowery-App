// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponseModel _$HomeResponseModelFromJson(Map<String, dynamic> json) =>
    HomeResponseModel(
      message: json['message'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestSeller: (json['bestSeller'] as List<dynamic>?)
          ?.map((e) => BestSeller.fromJson(e as Map<String, dynamic>))
          .toList(),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => Occasion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeResponseModelToJson(HomeResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'categories': instance.categories,
      'bestSeller': instance.bestSeller,
      'occasions': instance.occasions,
    };
