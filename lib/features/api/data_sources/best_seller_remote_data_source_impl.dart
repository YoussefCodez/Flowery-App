import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/best_seller_values.dart';
import 'package:flowery/features/api/api_client/best_seller_api_client.dart';
import 'package:flowery/features/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flowery/features/data/models/response/best_seller_products_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRemoteDataSourceContract)
class BestSellerRemoteDataSourceImpl
    implements BestSellerRemoteDataSourceContract {
  final BestSellerApiClient apiClient;

  BestSellerRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<BestSellerProductsResponseModel>>
  getBestSellerProducts() async {
    try {
      final response = await apiClient.getBestSellerProducts();

      return Success<BestSellerProductsResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<BestSellerProductsResponseModel>(
        exception: e.response!.data[BestSellerValues.error],
      );
    }
  }
}
