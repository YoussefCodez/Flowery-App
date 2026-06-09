import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/model/response_model/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/model/response_model/verify_email_response.dart';
import 'package:flowery/features/forget_password/domain/repository/forget_password_repo_contract.dart';
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
  ) async {
    final response = await dataSource.forgetPassword(request);
    switch (response) {
      case Success<ForgetPasswordResponse>():
        return Success<ForgetPasswordResponse>(data: response.data);
      case Error<ForgetPasswordResponse>(:final exception):
        return Error<ForgetPasswordResponse>(exception: exception);
    }
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(VerifyResetPassword request) async {
    final response = await dataSource.verifyEmail(request);
    switch (response) {
      case Success<VerifyEmailResponse>():
        return response;

      case Error<VerifyEmailResponse>():
        return response;
    }
  }


  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {
    final response = await dataSource.resetPassword(request);
    switch (response) {
      case Success<ResetPasswordResponse>():
        return Success<ResetPasswordResponse>(data: response.data);
      case Error<ResetPasswordResponse>(:final exception):
        return Error<ResetPasswordResponse>(exception: exception);
      
    }
  }












}
