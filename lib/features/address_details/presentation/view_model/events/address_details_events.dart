import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';

sealed class AddressDetailsEvents {}

class LoadGovernoratesEvent extends AddressDetailsEvents {}

class LoadCitiesEvent extends AddressDetailsEvents {}

class SelectGovernorateEvent extends AddressDetailsEvents {
  final GovernorateModel governorate;
  SelectGovernorateEvent(this.governorate);
}

class SelectCityEvent extends AddressDetailsEvents {
  final CityModel city;
  SelectCityEvent(this.city);
}

class UpdateLocationEvent extends AddressDetailsEvents {
  final double latitude;
  final double longitude;
  final String governorateName;
  final String cityName;

  UpdateLocationEvent({
    required this.latitude,
    required this.longitude,
    required this.governorateName,
    required this.cityName,
  });
}

class GetCurrentDeviceLocationEvent extends AddressDetailsEvents {}

class SelectLocationOnMapEvent extends AddressDetailsEvents {
  final double latitude;
  final double longitude;
  SelectLocationOnMapEvent({required this.latitude, required this.longitude});
}

class LoadAddressForEditEvent extends AddressDetailsEvents {
  final AddressDetailsDtoEntity address;
  LoadAddressForEditEvent(this.address);
}

class SaveAddressDetailsEvent extends AddressDetailsEvents {}
