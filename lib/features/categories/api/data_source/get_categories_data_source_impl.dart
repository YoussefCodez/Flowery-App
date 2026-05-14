import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/categories/api/api_client/categories_api_client.dart';
import 'package:flowery/features/categories/data/datasources/get_categories_data_source.dart';
import 'package:flowery/features/categories/data/models/category_response_model.dart';
import 'package:flowery/features/categories/data/models/product_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCategoriesDataSourceContract)
class GetCategoriesDataSourceImpl implements GetCategoriesDataSourceContract {
  final CategoriesApiClient _apiClient;

  GetCategoriesDataSourceImpl(this._apiClient);

  @override
  Future<Result<CategoryResponseModel>> getAllCategories() async {
    try {
      final response = await _apiClient.getAllCategories();
      return Success(data: response);
    } catch (e) {
      if (e is DioException) {
        return Error(exception: ServerFailure(errorMessage: e.message ?? ''));
      }
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<ProductResponseModel>> getProductsByCategory(String? categoryId) async {
    try {
      final response = await _apiClient.getProductsByCategory(categoryId);
      return Success(data: response);
    } catch (e) {
      if (e is DioException) {
        return Error(exception: ServerFailure(errorMessage: e.message ?? ''));
      }
      return Error(exception: Exception(e.toString()));
    }
  }
}
