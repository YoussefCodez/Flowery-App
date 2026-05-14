import 'package:json_annotation/json_annotation.dart';
import '../../../../core/models/metadata_model.dart';
import 'category_model.dart';

part 'category_response_model.g.dart';

@JsonSerializable()
class CategoryResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final MetadataModel? metadata;
  @JsonKey(name: 'categories')
  final List<CategoryModel>? categories;

  CategoryResponseModel({
    this.message,
    this.metadata,
    this.categories,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
}
