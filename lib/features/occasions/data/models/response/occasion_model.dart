import 'package:flowery/core/const/occasions_values.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_model.g.dart';

@JsonSerializable()
class Occasion {
  @JsonKey(name: OccasionsValues.id)
  String id;
  @JsonKey(name: OccasionsValues.name)
  String name;
  @JsonKey(name: OccasionsValues.slug)
  String slug;
  @JsonKey(name: OccasionsValues.image)
  String image;
  @JsonKey(name: OccasionsValues.isSuperAdmin)
  bool isSuperAdmin;
  @JsonKey(name: OccasionsValues.createdAt)
  DateTime createdAt;
  @JsonKey(name: OccasionsValues.updatedAt)
  DateTime updatedAt;
  @JsonKey(name: OccasionsValues.productsCount)
  int productsCount;

  Occasion({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.productsCount,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) =>
      _$OccasionFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionToJson(this);

  OccasionEntity toDomain() {
    return OccasionEntity(
      name: name,
      id:id
    );
  }
}
