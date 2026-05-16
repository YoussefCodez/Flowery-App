import 'package:flowery/config/base_response/base_response.dart';

import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/search_repo_contract.dart';
import '../../domain/search_entity/product_entity.dart';
import '../model/product_model.dart';
import '../search_remote_data/search_remote_data_contract.dart';

@Injectable(as: SearchRepoContract)
class SearchRepoImpl implements SearchRepoContract {
  final SearchRemoteDataSourceContract remoteDataSource;
  SearchRepoImpl(this.remoteDataSource);

  @override
  Future<Result<List<ProductEntity>>> searchProducts({
    required String search,

  }) async {
    final response = await remoteDataSource.searchProducts(
      search: search,

    );
    switch (response) {
      case Success<List<Product>>():
        return Success<List<ProductEntity>>(
          data: response.data?.map((e) => e.toDomain()).toList(),
        );
      case Error<List<Product>>(:final exception):
        return Error<List<ProductEntity>>(exception: exception);
    }
  }
}