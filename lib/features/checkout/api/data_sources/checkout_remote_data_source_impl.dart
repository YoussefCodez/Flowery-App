import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/checkout_values.dart';
import 'package:flowery/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flowery/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowery/features/checkout/data/models/checkout_session_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRemoteDataSourceContract)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSourceContract {
  final CheckoutApiClient apiClient;
  CheckoutRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Result<CheckoutSessionResponseModel>> checkOutSession() async {
    try {
      final response = await apiClient.checkOutSession();
      return Success<CheckoutSessionResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CheckoutSessionResponseModel>(
        exception: Exception(e.response!.data[CheckoutValues.error]),
      );
    }
  }
}
