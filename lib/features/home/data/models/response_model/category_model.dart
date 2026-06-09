import 'package:flowery/features/home/domain/home_enitiy/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class Category {
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

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  CategoryEntity toDomain() => CategoryEntity(
    id: id,
    name: name,
    slug: slug,
    image: image,
    isSuperAdmin: isSuperAdmin,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
