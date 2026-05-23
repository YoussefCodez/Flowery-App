import 'dart:convert';

import 'package:flowery/core/const/cart_values.dart';
import 'package:flowery/features/cart/data/models/responses/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_response_model.g.dart';

CartResponseModel cartResponseModelFromJson(String str) =>
    CartResponseModel.fromJson(json.decode(str));

String cartResponseModelToJson(CartResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CartResponseModel {
  @JsonKey(name: CartValues.message)
  String? message;

  @JsonKey(name: CartValues.numOfCartItems)
  int? numOfCartItems;

  @JsonKey(name: CartValues.cart)
  Cart? cart;

  CartResponseModel({this.message, this.numOfCartItems, this.cart});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);
}





