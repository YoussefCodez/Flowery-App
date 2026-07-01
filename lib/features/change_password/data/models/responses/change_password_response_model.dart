import 'package:flowery/core/const/change_password_values.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'change_password_response_model.g.dart';

ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) =>
    ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ChangePasswordResponseModel {
  @JsonKey(name: ChangePasswordValues.message)
  String? message;
  @JsonKey(name: ChangePasswordValues.token)
  String? token;

  ChangePasswordResponseModel({this.message, this.token});

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseModelToJson(this);
}
