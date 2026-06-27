import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';

abstract interface class AddressDetailsDataSourceContract {
  Future<Result<AddressDetailsResponce>> updateAddressDetails(
    AddressDetailsRequest request,
  );
  Future<Result<AddressDetailsEntity>> getSavedAddresses();

  Future<Result<AddressDetailsResponce>> deleteAddress(String addressId);
}
