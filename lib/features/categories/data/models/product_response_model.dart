import 'package:json_annotation/json_annotation.dart';
import '../../../../core/models/metadata_model.dart';
import 'product_model.dart';

part 'product_response_model.g.dart';

@JsonSerializable()
class ProductResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final MetadataModel? metadata;
  @JsonKey(name: 'products')
  final List<ProductModel>? products;

  ProductResponseModel({
    this.message,
    this.metadata,
    this.products,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}
