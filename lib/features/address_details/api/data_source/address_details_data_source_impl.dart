import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/address_details_values.dart';
import 'package:flowery/features/address_details/api/api_client/address_details_api_client.dart';
import 'package:flowery/features/address_details/data/data_source/address_details_data_source_contract.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsDataSourceContract)
class AddressDetailsDataSourceImpl
    implements AddressDetailsDataSourceContract {
      final AddressDetailsApiClient apiClient;

  AddressDetailsDataSourceImpl({required this.apiClient});
  @override
  Future<Result<AddressDetailsResponce>> updateAddressDetails(AddressDetailsRequest request)async {
    try{
      final response=await apiClient.updateUserAddressDetails(request);
      return Success<AddressDetailsResponce>(data: response);
    }on DioException catch(e){
      return Error<AddressDetailsResponce>(exception: Exception(e.response?.data?[AddressDetailsValues.message ] ));
    }
  }}
