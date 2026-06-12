import 'package:flowery/featuers/main_profile/data/model/user_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_response_model.g.dart';
@JsonSerializable()
class ProfileResponseModel {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  User? user;

  ProfileResponseModel({
    this.message,
    this.user,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}


