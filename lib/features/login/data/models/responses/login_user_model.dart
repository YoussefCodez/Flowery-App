import 'package:flowery/core/const/login_values.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_user_model.g.dart';

@JsonSerializable()
class LoginUserModel {
  @JsonKey(name: LoginValues.id)
  String id;
  @JsonKey(name: LoginValues.firstName)
  String firstName;
  @JsonKey(name: LoginValues.lastName)
  String lastName;
  @JsonKey(name: LoginValues.email)
  String email;
  @JsonKey(name: LoginValues.gender)
  String gender;
  @JsonKey(name: LoginValues.phone)
  String phone;
  @JsonKey(name: LoginValues.photo)
  String photo;
  @JsonKey(name: LoginValues.role)
  String role;
  @JsonKey(name: LoginValues.wishlist)
  List<dynamic> wishlist;
  @JsonKey(name: LoginValues.addresses)
  List<dynamic> addresses;
  @JsonKey(name: LoginValues.createdAt)
  DateTime createdAt;

  LoginUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.wishlist,
    required this.addresses,
    required this.createdAt,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserModelToJson(this);

  LoginUserEntity toDomain() {
  return LoginUserEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    gender: gender,
    phone: phone,
    photo: photo,
  );
}
}
