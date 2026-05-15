import 'package:json_annotation/json_annotation.dart';

import '../../../domain/home_enitiy/occasion_enitity.dart';
part 'occasion_model.g.dart';

@JsonSerializable()
class Occasion {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  Occasion({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });
  OccasionEntity toDomain() => OccasionEntity(
    id: id,
    name: name,
    slug: slug,
    image: image,
    isSuperAdmin: isSuperAdmin,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
  factory Occasion.fromJson(Map<String, dynamic> json) => _$OccasionFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}
