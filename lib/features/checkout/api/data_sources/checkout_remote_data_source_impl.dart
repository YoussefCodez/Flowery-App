import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/handle_errors.dart';
import 'package:flowery/core/const/checkout_values.dart';
import 'package:flowery/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flowery/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/data/models/responses/create_credit_order_response.dart';
import 'package:flowery/features/checkout/data/models/responses/create_cash_order_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRemoteDataSourceContract)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSourceContract {
  final CheckoutApiClient apiClient;
  CheckoutRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Result<CreateCreditOrderResponse>> checkOutSession() async {
    try {
      final response = await apiClient.createCreditOrder();
      return Success<CreateCreditOrderResponse>(data: response);
    } on DioException catch (e) {
      return Error<CreateCreditOrderResponse>(
        exception: Exception(handleError(e, null)),
      );
    }
  }

  @override
  Future<Result<CreateCashOrderResponse>> createCashOrder(
    CreateCashOrderRequest request,
  ) async {
    try {
      final response = await apiClient.createCashOrder(request);
      return Success<CreateCashOrderResponse>(data: response);
    } on DioException catch (e) {
      return Error<CreateCashOrderResponse>(
        exception: Exception(handleError(e, null)),
      );
    }
  }
}
