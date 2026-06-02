import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/models/response_model/home_response_model.dart';
import 'package:injectable/injectable.dart';
import '../../api/home_api_client/home_api_client.dart';
import 'home_remote_data_source_contract.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract {
  final HomeApiClient homeApiClient;

  HomeRemoteDataSourceImpl(this.homeApiClient);

  @override
  Future<Result<HomeResponseModel>> getHomeData() async {
    try {
      final response = await homeApiClient.getHomeData();
      return Success(data: response);
    } catch (e) {
      return Error(exception: _handleException(e));
    }
  }

  Exception _handleException(Object e) {
    if (e is DioException) return e;
    if (e is TimeoutException) return e;
    return Exception(e.toString());
  }
}
