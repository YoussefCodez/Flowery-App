import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/data_source/address_details_data_source_remote_contract.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/repo/address_details_repo_remote_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRepoRemoteContract)
class AddressDetailsRepoRemoteImpl implements AddressDetailsRepoRemoteContract {
  final AddressDetailsDataSourceRemoteContract dataSource;
  AddressDetailsRepoRemoteImpl({required this.dataSource});
  @override
  Future<Result<AddressDetailsResponseEntity>> updateAddressDetails(
    AddressDetailsRequest request,
  ) async {
    final response = await dataSource.updateAddressDetails(request);
    switch (response) {
      case Success<AddressDetailsResponce>():
        return Success<AddressDetailsResponseEntity>(
          data: response.data?.toDomain(),
        );
      case Error<AddressDetailsResponce>():
        return Error<AddressDetailsResponseEntity>(
          exception: response.exception,
        );
    }
  }
}
