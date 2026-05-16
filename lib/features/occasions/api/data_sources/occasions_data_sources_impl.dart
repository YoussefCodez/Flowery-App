import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/occasions_values.dart';
import 'package:flowery/features/occasions/api/api_client/occasions_api_client.dart';
import 'package:flowery/features/occasions/data/data_sources/occasions_data_sources_contract.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_products_response_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasions_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionsDataSourcesContract)
class OccasionsDataSourcesImpl implements OccasionsDataSourcesContract {
  final OccasionsApiClient apiClient;
  OccasionsDataSourcesImpl({required this.apiClient});

  @override
  Future<Result<OccasionsResponseModel>> getOccasions() async {
    try {
      final response = await apiClient.getOcassions();

      return Success<OccasionsResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<OccasionsResponseModel>(
        exception: e.response!.data[OccasionsValues.error],
      );
    }
  }

  @override
  Future<Result<OccasionProductsResponseModel>> getProductsOfSpecificOccasion(
    String occasionId,
  ) async {
    try {
      final response = await apiClient.getProductsOfSpecificOccasion(
        occasionId,
      );

      return Success<OccasionProductsResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<OccasionProductsResponseModel>(
        exception: Exception(e.response!.data[OccasionsValues.error]),
      );
    }
  }
}
