import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/domain/entities/best_seller_product_entity.dart';

abstract interface class BestSellerRepoContract {
  Future<Result<List<BestSellerProductEntity>>> getBestSellerProducts();
}
