import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_products_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasions_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'occasions_api_client.g.dart';

@injectable
@RestApi()
abstract class OccasionsApiClient {
  @factoryMethod
  factory OccasionsApiClient(Dio dio) = _OccasionsApiClient;

  @GET(AppEndPoints.occasions)
  Future<OccasionsResponseModel> getOcassions();

  @GET(AppEndPoints.products)
  Future<OccasionProductsResponseModel> getProductsOfSpecificOccasion(
    @Query(AppEndPoints.occasion) String occasionId,
  );
}
