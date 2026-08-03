import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flowery/features/address_details/domain/repo/address_details_repo_local_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetGovernoratesUseCaseLocal {
  final AddressDetailsRepoLocalContract repository;

  GetGovernoratesUseCaseLocal(this.repository);

  Future<List<GovernorateModel>> call() {
    return repository.getGovernorates();
  }
}