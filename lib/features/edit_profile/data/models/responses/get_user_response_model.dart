import 'package:flowery/features/edit_profile/data/models/responses/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_user_response_model.g.dart';

GetUserResponseModel getUserResponseModelFromJson(String str) => GetUserResponseModel.fromJson(json.decode(str));

String getUserResponseModelToJson(GetUserResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetUserResponseModel {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "user")
    User? user;

    GetUserResponseModel({
        this.message,
        this.user,
    });

    factory GetUserResponseModel.fromJson(Map<String, dynamic> json) => _$GetUserResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetUserResponseModelToJson(this);
}


