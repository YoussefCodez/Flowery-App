import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "wishlist")
  List<dynamic>? wishlist;
  @JsonKey(name: "addresses")
  List<dynamic>? addresses;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "passwordChangedAt")
  DateTime? passwordChangedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
    this.passwordChangedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  UserEntity toDomain() {
    return UserEntity(
      photo: photo ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      phone: phone ?? "",
      email: email ?? "",
      gender: gender ?? "male",
    );
  }
}
