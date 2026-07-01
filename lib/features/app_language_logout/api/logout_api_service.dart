import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/app_language_logout/data/models/logout_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'logout_api_service.g.dart';

@RestApi()
abstract class LogoutApiService {
  factory LogoutApiService(Dio dio, {String? baseUrl}) = _LogoutApiService;

  @GET(AppEndPoints.logout)
  Future<LogoutResponseModel> logout();
}
