import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config/api/app_endpoints.dart';
import '../../data/models/response_model/home_response_model.dart';


part 'home_api_client.g.dart';
@injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(AppEndPoints.getHomeData)
  Future<HomeResponseModel> getHomeData();


}
