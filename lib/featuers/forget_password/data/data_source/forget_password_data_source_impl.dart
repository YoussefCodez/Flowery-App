import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/forget_password/api/forget_password_api_client.dart';
import 'package:flowery/featuers/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/reset_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/verify_reset_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/forget_password_response.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/reset_password_response.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/verify_email_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error/api_executor.dart';

const bool isMock = true;

@Injectable(as: ForgetPasswordDataSourceContract)
class ForgetPasswordDataSourceImpl
    implements ForgetPasswordDataSourceContract {

  final ForgetPasswordApiClient client;

  ForgetPasswordDataSourceImpl({
    required this.client,
  });

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) async {
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(
        data: ForgetPasswordResponse(),
      );
    }

    return ApiExecutor.execute<ForgetPasswordResponse>(
          () => client.forgetPassword(request),
    );
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(
      VerifyResetPasswordRequest request,
      ) async {
    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(
        data: VerifyEmailResponse(),
      );
    }

    // ================= REAL API =================
    return ApiExecutor.execute<VerifyEmailResponse>(
          () => client.verifyEmail(request),
    );
  }

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {
    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success(
        data: ResetPasswordResponse(),
      );
    }

    // ================= REAL API =================
    return ApiExecutor.execute<ResetPasswordResponse>(
          () => client.resetPassword(request),
    );
  }
}