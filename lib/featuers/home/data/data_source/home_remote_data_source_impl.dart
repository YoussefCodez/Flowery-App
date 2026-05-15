import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/models/response_model/best_seller_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/home_response_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/occasion_model.dart';
import 'package:injectable/injectable.dart';

import '../../api/home_api_client/home_api_client.dart';
import '../models/response_model/category_model.dart';
import 'home_remote_data_source_contract.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract{
  final HomeApiClient homeApiClient;

  HomeRemoteDataSourceImpl(this.homeApiClient);

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final response = await homeApiClient.getHomeData();
      return Success<List<Category>>(
        data: response.categories ?? [],
      );
    } catch (e) {
      if (e is DioException) {
        return Error<List<Category>>(
          exception: e,
        );
      } else if (e is TimeoutException) {
        return Error<List<Category>>(
          exception: e,
        );
      }

      return Error<List<Category>>(
        exception: Exception(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<BestSeller>>> getBestSellers() async {
    try {
      final response = await homeApiClient.getHomeData();
      return Success<List<BestSeller>>(
        data: response.bestSeller ?? [],
      );
    } catch (e) {
      if (e is DioException) {
        return Error<List<BestSeller>>(
          exception: e,
        );
      } else if (e is TimeoutException) {
        return Error<List<BestSeller>>(
          exception: e,
        );
      }

      return Error<List<BestSeller>>(
        exception: Exception(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<Occasion>>> getOccasions() async {
    try {
      final response = await homeApiClient.getHomeData();
      return Success<List<Occasion>>(
        data: response.occasions ?? [],
      );
    } catch (e) {
      if (e is DioException) {
        return Error<List<Occasion>>(
          exception: e,
        );
      } else if (e is TimeoutException) {
        return Error<List<Occasion>>(
          exception: e,
        );
      }

      return Error<List<Occasion>>(
        exception: Exception(e.toString()),
      );
    }
  }

}
