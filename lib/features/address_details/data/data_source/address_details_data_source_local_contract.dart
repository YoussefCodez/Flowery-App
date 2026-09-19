import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';

abstract interface class AddressDataSourceLocalContract {
  Future<List<GovernorateModel>> getGovernorates();

  Future<List<CityModel>> getCities();
}