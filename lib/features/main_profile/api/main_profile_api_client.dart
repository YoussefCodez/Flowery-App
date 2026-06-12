import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../config/api/app_endpoints.dart';
import '../data/model/profile_response_model.dart';

part 'main_profile_api_client.g.dart';

@injectable
@RestApi()
abstract class MainProfileApiClient {
  @factoryMethod
  factory MainProfileApiClient(Dio dio)= _MainProfileApiClient;

  @GET(AppEndPoints.getProfileData)
  Future<ProfileResponseModel> getProfileData();

}