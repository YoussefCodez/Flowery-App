import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'create_cash_order_request.g.dart';

CreateCashOrderRequest createCashOrderRequestFromJson(String str) =>
    CreateCashOrderRequest.fromJson(json.decode(str));

String createCashOrderRequestToJson(CreateCashOrderRequest data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CreateCashOrderRequest {
  @JsonKey(name: 'shippingAddress')
  final ShippingAddress shippingAddress;

  CreateCashOrderRequest({
    required this.shippingAddress,
  });

  factory CreateCashOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCashOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCashOrderRequestToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: 'street')
  final String street;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'long')
  final String long;

  ShippingAddress({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}