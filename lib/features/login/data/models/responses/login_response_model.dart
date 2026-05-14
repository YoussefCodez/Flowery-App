import 'package:flowery/core/const/login_values.dart';
import 'package:flowery/features/login/data/models/responses/login_user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'login_response_model.g.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: LoginValues.message)
  String? message;
  @JsonKey(name: LoginValues.user)
  LoginUserModel? user;
  @JsonKey(name: LoginValues.token)
  String? token;

  LoginResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
