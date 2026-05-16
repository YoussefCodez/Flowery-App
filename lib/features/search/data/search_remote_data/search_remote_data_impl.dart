import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/search/data/search_remote_data/search_remote_data_contract.dart';
import 'package:injectable/injectable.dart';

import '../../api/search_api_client.dart';
import '../model/product_model.dart';

@Injectable(as: SearchRemoteDataSourceContract)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSourceContract {
  final SearchApiClient searchApiClient;
  SearchRemoteDataSourceImpl(this.searchApiClient);

  @override
  Future<Result<List<Product>>> searchProducts({
    required String search,

  }) async {
    try {
      final response = await searchApiClient.searchProducts(search);
      return Success<List<Product>>(
        data: response.products ?? [],
      );
    } catch (e) {
      if (e is DioException) {
        return Error<List<Product>>(exception: e);
      } else if (e is TimeoutException) {
        return Error<List<Product>>(exception: e);
      }
      return Error<List<Product>>(
        exception: Exception(e.toString()),
      );
    }
  }
}