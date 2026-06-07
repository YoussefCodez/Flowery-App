import 'package:flowery/core/const/change_password_values.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'change_password_request_model.g.dart';

ChangePasswordRequestModel changePasswordRequestModelFromJson(String str) => ChangePasswordRequestModel.fromJson(json.decode(str));

String changePasswordRequestModelToJson(ChangePasswordRequestModel data) => json.encode(data.toJson());

@JsonSerializable()
class ChangePasswordRequestModel {
    @JsonKey(name: ChangePasswordValues.password)
    String? password;
    @JsonKey(name: ChangePasswordValues.newPassword)
    String? newPassword;

    ChangePasswordRequestModel({
        this.password,
        this.newPassword,
    });

    factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestModelFromJson(json);

    Map<String, dynamic> toJson() => _$ChangePasswordRequestModelToJson(this);
}
