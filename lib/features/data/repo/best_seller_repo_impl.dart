import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flowery/features/domain/entities/best_seller_product_entity.dart';
import 'package:flowery/features/domain/repo/best_seller_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRepoContract)
class BestSellerRepoImpl implements BestSellerRepoContract {
  final BestSellerRemoteDataSourceContract remoteDataSourceContract;
  BestSellerRepoImpl({required this.remoteDataSourceContract});

  @override
  Future<Result<List<BestSellerProductEntity>>> getBestSellerProducts() async{
    final response = await remoteDataSourceContract.getBestSellerProducts();

    return response.when(
      success: (data) {
        return Success<List<BestSellerProductEntity>>(
          data: data!.bestSeller.map((e) => e.toDomain()).toList(),
        );
      },
      error: (exception) {
        return Error<List<BestSellerProductEntity>>(exception: exception);
      },
    );
  }
}
