import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/domain/repo/address_details_repo_local_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCitiesUseCaseLocal {
  final AddressDetailsRepoLocalContract repository;

  GetCitiesUseCaseLocal(this.repository);

  Future<List<CityModel>> call() {
    return repository.getCities();
  }
}