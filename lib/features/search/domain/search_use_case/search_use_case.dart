import 'package:flowery/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';


import '../repo_contract/search_repo_contract.dart';
import '../search_entity/product_entity.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepoContract repo;
  SearchProductsUseCase(this.repo);

  Future<Result<List<ProductEntity>>> call({
    required String search,
  }) async {
    return repo.searchProducts(
      search: search,
    );
  }
}