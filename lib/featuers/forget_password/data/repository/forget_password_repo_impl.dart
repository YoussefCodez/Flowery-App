import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/verify_reset_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/forget_password_response.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/verify_email_response.dart';
import 'package:flowery/featuers/forget_password/domain/repository/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../model/reqest_models/reset_password_request.dart';
import '../model/response_model/reset_password_response.dart';

@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  ForgetPasswordDataSourceContract dataSource;

  ForgetPasswordRepoImpl(this.dataSource);

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) {
    return dataSource.forgetPassword(request);
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPasswordRequest request) async {
    return await dataSource.verifyEmail(request);

  }


  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {
    return  await dataSource.resetPassword(request);

  }












}
