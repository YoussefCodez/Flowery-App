import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/categories/domain/entities/category_entity.dart';
import 'package:flowery/features/categories/domain/repositories/get_categories_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllCategoriesUseCase {
  final GetCategoriesContract _repository;

  GetAllCategoriesUseCase(this._repository);

  Future<Result<List<CategoryEntity>>> call() async {
    return await _repository.getAllCategories();
  }
}