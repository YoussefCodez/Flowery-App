import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../config/api/app_endpoints.dart';
import '../data/model/search_response_model.dart';
part 'search_api_client.g.dart';

@injectable
@RestApi()
abstract class SearchApiClient {
  @factoryMethod
  factory SearchApiClient(Dio dio) = _SearchApiClient;

  @GET(AppEndPoints.getProduct)
  Future<SearchResponseModel> searchProducts(
      @Query("search") String search,);
      // @Query("page") int page,
      // @Query("limit") int limit,
      // );
}