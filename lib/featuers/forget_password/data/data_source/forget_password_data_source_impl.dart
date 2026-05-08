import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/forget_password/api/forget_password_client.dart';
import 'package:flowery/featuers/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/reset_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/verify_reset_password_request.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/forget_password_response.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/reset_password_response.dart';
import 'package:flowery/featuers/forget_password/data/model/response_model/verify_email_response.dart';
import 'package:injectable/injectable.dart';

const bool isMock = true;

@Injectable(as: ForgetPasswordDataSourceContract)
class ForgetPasswordDataSourceImpl
    implements ForgetPasswordDataSourceContract {

  final ForgetPasswordClient client;

  ForgetPasswordDataSourceImpl({
    required this.client,
  });

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) async {

    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success<ForgetPasswordResponse>(
        data: ForgetPasswordResponse(),
      );
    }

    // ================= REAL API =================
    try {

      final response = await client.forgetPassword(request);

      return Success<ForgetPasswordResponse>(
        data: response,
      );

    } on DioException catch (e) {

      final serverMessage =
          e.response?.data['message'] ??
              "Something went wrong";

      return Error<ForgetPasswordResponse>(
        exception: Exception(serverMessage),
      );

    } on TimeoutException catch (e) {

      return Error<ForgetPasswordResponse>(
        exception: Exception(
          e.message ?? "Timeout Exception",
        ),
      );

    } catch (e) {

      return Error<ForgetPasswordResponse>(
        exception: Exception(e.toString()),
      );
    }
  }

  @override
  Future<Result<VerifyEmailResponse>> verifyEmail(
      VerifyResetPassword request,
      ) async {

    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success<VerifyEmailResponse>(
        data: VerifyEmailResponse(),
      );
    }

    // ================= REAL API =================
    try {

      final response = await client.verifyEmail(request);

      return Success<VerifyEmailResponse>(
        data: response,
      );

    } on DioException catch (e) {

      return Error<VerifyEmailResponse>(
        exception: Exception(
          e.response?.data['message'] ??
              e.message,
        ),
      );

    } on TimeoutException catch (e) {

      return Error<VerifyEmailResponse>(
        exception: Exception(
          e.message ?? "Timeout Exception",
        ),
      );

    } catch (e) {

      return Error<VerifyEmailResponse>(
        exception: Exception(e.toString()),
      );
    }
  }

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {

    // ================= MOCK =================
    if (isMock) {
      await Future.delayed(const Duration(seconds: 2));

      return Success<ResetPasswordResponse>(
        data: ResetPasswordResponse(),
      );
    }

    // ================= REAL API =================
    try {

      final response = await client.resetPassword(request);

      return Success<ResetPasswordResponse>(
        data: response,
      );

    } on DioException catch (e) {

      final serverMessage =
          e.response?.data['message'] ??
              "Something went wrong";

      return Error<ResetPasswordResponse>(
        exception: Exception(serverMessage),
      );

    } on TimeoutException catch (e) {

      return Error<ResetPasswordResponse>(
        exception: Exception(
          e.message ?? "Timeout Exception",
        ),
      );

    } catch (e) {

      return Error<ResetPasswordResponse>(
        exception: Exception(e.toString()),
      );
    }
  }
}