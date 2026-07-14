import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/repo/address_details_repo_remote_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressDetailsUseCaseRemote {
  final AddressDetailsRepoRemoteContract repo;
  UpdateAddressDetailsUseCaseRemote({required this.repo});
  Future<Result<AddressDetailsResponseEntity>> call(
    AddressDetailsRequest request,
  ) async {
    return repo.updateAddressDetails(request);
  }
}
