// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderResponseModel _$MyOrderResponseModelFromJson(
  Map<String, dynamic> json,
) => MyOrderResponseModel(
  message: json['message'] as String?,
  order: json['order'] == null
      ? null
      : Order.fromJson(json['order'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MyOrderResponseModelToJson(
  MyOrderResponseModel instance,
) => <String, dynamic>{'message': instance.message, 'order': instance.order};
