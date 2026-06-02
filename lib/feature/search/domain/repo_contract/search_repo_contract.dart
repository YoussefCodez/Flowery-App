import 'package:flowery/config/base_response/base_response.dart';

import '../search_entity/product_entity.dart';

abstract class SearchRepoContract {
  Future<Result<List<ProductEntity>>> searchProducts({
    required String search,

  });
}