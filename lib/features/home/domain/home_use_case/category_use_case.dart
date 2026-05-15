import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../home_enitiy/category_entity.dart';
import '../repo_contract/home_repo_contract.dart';
@injectable

class GetCategoriesUseCase {
  final HomeRepoContract repo;
  GetCategoriesUseCase(this.repo);
  Future<Result<List<CategoryEntity>>> call() => repo.getCategory();
}