import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_password_request.g.dart';

@JsonSerializable()
class VerifyResetPassword {
  @JsonKey(name: "resetCode")
  String? resetCode;

  VerifyResetPassword({
    this.resetCode,
  });

  factory VerifyResetPassword.fromJson(Map<String, dynamic> json) => _$VerifyResetPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetPasswordToJson(this);
}
