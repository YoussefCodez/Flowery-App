import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../home_enitiy/home_entity.dart';
import '../repo_contract/home_repo_contract.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepoContract repo;

  GetHomeDataUseCase(this.repo);

  Future<Result<HomeEntity>> call() => repo.getHomeData();
}
