import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/data_source/address_details_data_source_contract.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/repo/address_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRepoContract)
class AddressDetailsRepoImpl implements AddressDetailsRepoContract {
  final AddressDetailsDataSourceContract dataSource;
  AddressDetailsRepoImpl({required this.dataSource});
  @override
  Future<Result<AddressDetailsEntity>> updateAddressDetails(AddressDetailsRequest request)async {
    final response = await dataSource.updateAddressDetails(request);
    switch (response) {
      case Success<AddressDetailsResponce>():
        return Success<AddressDetailsEntity>(
            data: response.data?.toDomain());
      case Error<AddressDetailsResponce>():
        return Error<AddressDetailsEntity>(exception: response.exception);
    }
    
  }
}
