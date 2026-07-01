import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'login_api_client.g.dart';

@injectable
@RestApi()
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(AppEndPoints.login)
  Future<LoginResponseModel> login(@Body() Map<String,dynamic> body);
}
