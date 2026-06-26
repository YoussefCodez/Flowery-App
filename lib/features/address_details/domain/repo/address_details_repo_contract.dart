import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';

abstract interface class AddressDetailsRepoContract {
  Future<Result<AddressDetailsEntity>> updateAddressDetails(AddressDetailsRequest request);
}