import 'package:flowery/core/const/occasions_values.dart';
import 'package:flowery/features/occasions/data/models/response/meta_data_model.dart';
import 'package:flowery/features/occasions/data/models/response/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'occasion_products_response_model.g.dart';

OccasionProductsResponseModel occasionProductsResponseModelFromJson(String str) => OccasionProductsResponseModel.fromJson(json.decode(str));

String occasionProductsResponseModelToJson(OccasionProductsResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class OccasionProductsResponseModel {
    @JsonKey(name: OccasionsValues.message)
    String message;
    @JsonKey(name: OccasionsValues.metadata)
    Metadata metadata;
    @JsonKey(name: OccasionsValues.products)
    List<Product> products;

    OccasionProductsResponseModel({
        required this.message,
        required this.metadata,
        required this.products,
    });

    factory OccasionProductsResponseModel.fromJson(Map<String, dynamic> json) => _$OccasionProductsResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$OccasionProductsResponseModelToJson(this);
}



