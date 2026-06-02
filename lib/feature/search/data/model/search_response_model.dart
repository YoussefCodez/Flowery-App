import 'package:flowery/feature/search/data/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meta_data_model.dart';

part 'search_response_model.g.dart';

@JsonSerializable()

class SearchResponseModel {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "metadata")
  Metadata? metadata;
  @JsonKey(name: "products")
  List<Product>? products;

  SearchResponseModel({
    this.message,
    this.metadata,
    this.products,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => _$SearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);
}




