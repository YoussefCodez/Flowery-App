import 'package:flowery/featuers/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/forget_password_response.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/model/reqest_models/reset_password_request.dart';
import '../../data/model/reqest_models/verify_reset_password_request.dart';
import '../../data/model/response_model/reset_password_response.dart';
import '../../data/model/response_model/verify_email_response.dart';

abstract class ForgetPasswordRepoContract {
  Future<Result<ForgetPasswordResponse>> forgetPassword(
    ForgetPasswordRequest request,
  );

  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPassword request);

  Future<Result<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  );
}
