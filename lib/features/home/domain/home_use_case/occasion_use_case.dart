import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../home_enitiy/occasion_enitity.dart';
import '../repo_contract/home_repo_contract.dart';
@injectable

class GetOccasionsUseCase {
  final HomeRepoContract repo;
  GetOccasionsUseCase(this.repo);
  Future<Result<List<OccasionEntity>>> call() => repo.getOccasion();
}