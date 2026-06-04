import 'package:json_annotation/json_annotation.dart';
part 'edit_user_model.g.dart';

@JsonSerializable()
class EditUserModel {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  EditUserModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  });

  Map<String, dynamic> toJson() => _$EditUserModelToJson(this);

  factory EditUserModel.fromJson(Map<String, dynamic> json) => _$EditUserModelFromJson(json);
}
