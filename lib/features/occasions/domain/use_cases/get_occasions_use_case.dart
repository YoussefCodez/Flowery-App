import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/repo/occasions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final OccasionsRepoContract repo;

  GetOccasionsUseCase({required this.repo});

  Future<Result<List<OccasionEntity>>> call() async {
    return await repo.getOccasions();
  }
}
