import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';

abstract interface class OccasionsRepoContract {
  Future<Result<List<OccasionEntity>>> getOccasions();

  Future<Result<List<ProductEntity>>> getProductsOfSpecificOccasion(String occasionId);
}