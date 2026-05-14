import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/categories/domain/entities/category_entity.dart';
import 'package:flowery/features/categories/domain/entities/product_entity.dart';
import 'package:flowery/features/categories/domain/repositories/get_categories_contract.dart';
import 'package:flowery/features/categories/data/datasources/get_categories_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetCategoriesContract)
class GetCategoriesImpl implements GetCategoriesContract {
  final GetCategoriesDataSourceContract _dataSource;

  const GetCategoriesImpl(this._dataSource);

  @override
  Future<Result<List<CategoryEntity>>> getAllCategories() async {
    final response = await _dataSource.getAllCategories();
    switch (response) {
      case Success(data: final data):
        final entities =
            data?.categories?.map((e) => e.toEntity()).toList() ?? [];
        return Success(data: entities);
      case Error(exception: final exception):
        return Error(exception: exception);
    }
  }

  @override
  Future<Result<List<ProductEntity>>> getProductsByCategory(String? categoryId) async {
    final response = await _dataSource.getProductsByCategory(categoryId);
    switch (response) {
      case Success(data: final data):
        final entities =
            data?.products?.map((e) => e.toEntity()).toList() ?? [];
        return Success(data: entities);
      case Error(exception: final exception):
        return Error(exception: exception);
    }
  }
}
