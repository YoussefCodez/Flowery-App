import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../config/api/app_endpoints.dart';
import '../data/model/my_order_model.dart';
part 'my_order_api_client.g.dart';
@injectable
@RestApi()
abstract class MyOrderApiClient {
  @factoryMethod
  factory MyOrderApiClient(Dio dio) = _MyOrderApiClient;
  @GET(AppEndPoints.my_order)
  Future<MyOrderResponseModel>getMyOrderData();
}