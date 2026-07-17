import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/my_order/api/my_order_api_client.dart';
import 'package:flowery/featuers/my_order/data/data_source/remote_data_source_contract.dart';
import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  RemoteDataSourceContract)
class RemoteDataSourceImpl implements RemoteDataSourceContract {
  final MyOrderApiClient apiClient;
  RemoteDataSourceImpl(this.apiClient);

  @override
  Future<Result<MyOrderResponseModel>> getMyOrderData() async {
    try{
      final response=await apiClient.getMyOrderData();
      return Success(data: response);

    }catch (e) {
      if (e is DioException) {
        return Error(exception: e);
      }

      if (e is TimeoutException) {
        return Error(exception: e);
      }

      return Error(
        exception: Exception(e.toString()),
      );
    }

  }

}