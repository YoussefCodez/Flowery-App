import 'package:flowery/core/const/occasions_values.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta_data_model.g.dart';

@JsonSerializable()
class Metadata {
  @JsonKey(name: OccasionsValues.currentPage)
  int currentPage;
  @JsonKey(name: OccasionsValues.limit)
  int limit;
  @JsonKey(name: OccasionsValues.totalPages)
  int totalPages;
  @JsonKey(name: OccasionsValues.totalItems)
  int totalItems;

  Metadata({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
