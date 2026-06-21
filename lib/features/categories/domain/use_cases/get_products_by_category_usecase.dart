import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/categories/domain/entities/product_entity.dart';
import 'package:flowery/features/categories/domain/repositories/get_categories_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetProductsByCategoryUseCase {
  final GetCategoriesContract _repository;

  GetProductsByCategoryUseCase(this._repository);

  Future<Result<List<ProductEntity>>> call([
    String? categoryId,
    String? sortOption,
  ]) async {
    return await _repository.getProductsByCategory(categoryId, sortOption);
  }
}
