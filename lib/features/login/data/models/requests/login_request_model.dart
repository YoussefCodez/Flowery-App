import 'package:flowery/core/const/login_values.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'login_request_model.g.dart';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class LoginRequestModel {
  @JsonKey(name: LoginValues.email)
  String email;
  @JsonKey(name: LoginValues.password)
  String password;

  LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
