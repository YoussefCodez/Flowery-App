import 'package:dio/dio.dart';
import 'package:flowery/featuers/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../config/api/app_endpoints.dart';
import '../data/model/reqest_models/reset_password_request.dart';
import '../data/model/reqest_models/verify_reset_password_request.dart';
import '../data/model/response_model/forget_password_response.dart';
import '../data/model/response_model/reset_password_response.dart';
import '../data/model/response_model/verify_email_response.dart';

part 'forget_password_client.g.dart';

@RestApi()
@injectable
abstract class ForgetPasswordClient {
  @factoryMethod
  factory ForgetPasswordClient(Dio dio) = _ForgetPasswordClient;

  @POST(AppEndPoints.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest request,
  );

  @POST(AppEndPoints.verifyResetPassword)
  Future<VerifyEmailResponse> verifyEmail(@Body() VerifyResetPassword request);

  @PUT(AppEndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);
}
