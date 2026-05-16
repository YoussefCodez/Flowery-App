import 'package:flowery/config/base_response/base_response.dart';
import '../model/product_model.dart';

abstract class SearchRemoteDataSourceContract {
  Future<Result<List<Product>>> searchProducts({required String search});
}
