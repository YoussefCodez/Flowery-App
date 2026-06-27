import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/repo/address_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSavedAddressesUseCase {
  final AddressDetailsRepoContract repo;
  GetSavedAddressesUseCase({required this.repo});

  Future<Result<AddressDetailsEntity>> call() async {
    return repo.getSavedAddresses();
  }
}