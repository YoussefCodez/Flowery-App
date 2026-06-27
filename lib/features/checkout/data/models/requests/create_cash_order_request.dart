// To parse this JSON data, do
//
//     final createCashOrderRequest = createCashOrderRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_cash_order_request.g.dart';

CreateCashOrderRequest createCashOrderRequestFromJson(String str) => CreateCashOrderRequest.fromJson(json.decode(str));

String createCashOrderRequestToJson(CreateCashOrderRequest data) => json.encode(data.toJson());

@JsonSerializable()
class CreateCashOrderRequest {
    @JsonKey(name: "shippingAddress")
    ShippingAddress? shippingAddress;

    CreateCashOrderRequest({
        this.shippingAddress,
    });

    factory CreateCashOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateCashOrderRequestFromJson(json);

    Map<String, dynamic> toJson() => _$CreateCashOrderRequestToJson(this);
}

@JsonSerializable()
class ShippingAddress {
    @JsonKey(name: "street")
    String? street;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "city")
    String? city;
    @JsonKey(name: "lat")
    String? lat;
    @JsonKey(name: "long")
    String? long;

    ShippingAddress({
        this.street,
        this.phone,
        this.city,
        this.lat,
        this.long,
    });

    factory ShippingAddress.fromJson(Map<String, dynamic> json) => _$ShippingAddressFromJson(json);

    Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}
