import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/domain/entities/best_seller_product_entity.dart';
import 'package:flowery/features/domain/repo/best_seller_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerProductsUseCase {
  final BestSellerRepoContract repo;
  GetBestSellerProductsUseCase({required this.repo});

  Future<Result<List<BestSellerProductEntity>>> call() async {
    return await repo.getBestSellerProducts();
  }
}
