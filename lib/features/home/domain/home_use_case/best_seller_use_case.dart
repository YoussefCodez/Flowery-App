import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../home_enitiy/best_seller_entity.dart';
import '../repo_contract/home_repo_contract.dart';
@injectable

class GetBestSellerUseCase {
  final HomeRepoContract repo;
  GetBestSellerUseCase(this.repo);
  Future<Result<List<BestSellerEntity>>> call() => repo.getBestSeller();
}