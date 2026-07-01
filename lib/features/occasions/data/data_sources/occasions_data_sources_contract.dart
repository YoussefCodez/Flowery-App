import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_products_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasions_response_model.dart';

abstract interface class OccasionsDataSourcesContract {
  Future<Result<OccasionsResponseModel>> getOccasions();

  Future<Result<OccasionProductsResponseModel>> getProductsOfSpecificOccasion(String occasionId);
}