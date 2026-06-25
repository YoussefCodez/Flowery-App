// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderResponseModel _$MyOrderResponseModelFromJson(
  Map<String, dynamic> json,
) => MyOrderResponseModel(
  message: json['message'] as String?,
  orders: (json['orders'] as List<dynamic>?)
      ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MyOrderResponseModelToJson(
  MyOrderResponseModel instance,
) => <String, dynamic>{'message': instance.message, 'orders': instance.orders};
