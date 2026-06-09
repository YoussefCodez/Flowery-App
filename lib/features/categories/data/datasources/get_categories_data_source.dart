import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/categories/data/models/category_response_model.dart';
import 'package:flowery/features/categories/data/models/product_response_model.dart';

abstract interface class GetCategoriesDataSourceContract {
  Future<Result<CategoryResponseModel>> getAllCategories();
  Future<Result<ProductResponseModel>> getProductsByCategory(String? categoryId);
}
