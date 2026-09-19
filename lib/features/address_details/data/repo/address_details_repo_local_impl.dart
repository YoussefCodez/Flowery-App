import 'package:flowery/features/address_details/domain/repo/address_details_repo_local_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRepoLocalContract)

class AddressDetailsRepoLocalImpl implements AddressDetailsRepoLocalContract{
   final AddressLocalDataSource localDataSource;

  AddressDetailsRepoLocalImpl(this.localDataSource);

  @override
  Future<List<GovernorateModel>> getGovernorates() {
    return localDataSource.getGovernorates();
  }

  @override
  Future<List<CityModel>> getCities() {
    return localDataSource.getCities();
  }
}