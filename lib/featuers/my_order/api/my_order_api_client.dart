import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config/api/app_endpoints.dart';
part 'my_order_api_client.g.dart';
@injectable
@RestApi()
abstract class MyOrderApiClient {
  @factoryMethod
  factory MyOrderApiClient(Dio dio) = _MyOrderApiClient;

  @GET(AppEndPoints.my_order)

  Future<MyOrderResponseModel>getMyOrderData();
}