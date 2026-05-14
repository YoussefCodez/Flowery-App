import 'package:flowery/config/base_response/base_response.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract interface class GetCategoriesContract {
  Future<Result<List<CategoryEntity>>> getAllCategories();
  Future<Result<List<ProductEntity>>> getProductsByCategory(String? categoryId);
}
