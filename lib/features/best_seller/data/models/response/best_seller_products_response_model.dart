// To parse this JSON data, do
//
//     final bestSellerProductsResponseModel = bestSellerProductsResponseModelFromJson(jsonString);

import 'package:flowery/core/const/best_seller_values.dart';
import 'package:flowery/features/best_seller/data/models/response/best_seller_product_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'best_seller_products_response_model.g.dart';

BestSellerProductsResponseModel bestSellerProductsResponseModelFromJson(String str) => BestSellerProductsResponseModel.fromJson(json.decode(str));

String bestSellerProductsResponseModelToJson(BestSellerProductsResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class BestSellerProductsResponseModel {
    @JsonKey(name: BestSellerValues.message)
    String message;
    @JsonKey(name: BestSellerValues.bestSeller)
    List<BestSellerProduct> bestSeller;

    BestSellerProductsResponseModel({
        required this.message,
        required this.bestSeller,
    });

    factory BestSellerProductsResponseModel.fromJson(Map<String, dynamic> json) => _$BestSellerProductsResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$BestSellerProductsResponseModelToJson(this);
}


