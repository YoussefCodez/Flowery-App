import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:flowery/features/address_details/data/models/responce/get_addresses_responce.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'address_details_api_client.g.dart';
@injectable
@RestApi()
abstract class AddressDetailsApiClient {
  @factoryMethod
  factory AddressDetailsApiClient(Dio dio) = _AddressDetailsApiClient;

  @PATCH(AppEndPoints.addressDetails)
  Future<AddressDetailsResponce> updateUserAddressDetails(@Body() AddressDetailsRequest addressDetailsRequest);
   @GET(AppEndPoints.addressDetails)
  Future<GetAddressesResponce> getSavedAddresses();

  @DELETE('${AppEndPoints.addressDetails}/{id}')
  Future<AddressDetailsResponce> deleteAddress(@Path('id') String id);
}
