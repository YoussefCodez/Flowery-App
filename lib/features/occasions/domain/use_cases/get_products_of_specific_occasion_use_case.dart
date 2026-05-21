import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/domain/repo/occasions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsOfSpecificOccasionUseCase {
  final OccasionsRepoContract repo;
  GetProductsOfSpecificOccasionUseCase({required this.repo});

  Future<Result<List<ProductEntity>>> call(String occasionId) {
    return repo.getProductsOfSpecificOccasion(occasionId);
  }
}
