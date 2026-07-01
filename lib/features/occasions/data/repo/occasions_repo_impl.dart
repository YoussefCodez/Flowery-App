import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/data/data_sources/occasions_data_sources_contract.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/domain/repo/occasions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionsRepoContract)
class OccasionsRepoImpl implements OccasionsRepoContract {
  final OccasionsDataSourcesContract dataSources;

  OccasionsRepoImpl({required this.dataSources});
  @override
  Future<Result<List<OccasionEntity>>> getOccasions() async {
    final response = await dataSources.getOccasions();

    return response.when(
      success: (data) {
        return Success<List<OccasionEntity>>(
          data: data!.occasions!.map((e) => e.toDomain()).toList(),
        );
      },
      error: (exception) {
        return Error<List<OccasionEntity>>(exception: exception);
      },
    );
  }

  @override
  Future<Result<List<ProductEntity>>> getProductsOfSpecificOccasion(
    String occasionId,
  ) async {
    final response = await dataSources.getProductsOfSpecificOccasion(
      occasionId,
    );
    return response.when(
      success: (data) {
        return Success<List<ProductEntity>>(
          data: data!.products!.map((e) => e.toDomain()).toList(),
        );
      },
      error: (exception) {
        return Error<List<ProductEntity>>(exception: exception);
      },
    );
  }
}
