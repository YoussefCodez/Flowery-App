import 'package:equatable/equatable.dart';
import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';

const _noChange = Object();

class AddressDetailsBaseState extends Equatable {
  final bool isLoadingGovernorates;
  final bool isLoadingCities;
  final bool isSavingAddress;
  final bool isFetchingCurrentLocation;
  final bool isFetchingAddressFromLocation;

  final List<GovernorateModel> governorates;
  final List<CityModel> allCities;
  final List<CityModel> filteredCities;

  final GovernorateModel? selectedGovernorate;
  final CityModel? selectedCity;

  final double? latitude;
  final double? longitude;

  final double? currentDeviceLatitude;
  final double? currentDeviceLongitude;

  final String governorateName;
  final String cityName;

  final AddressDetailsEntity? address;

  final String errorMessage;

  const AddressDetailsBaseState({
    this.isLoadingGovernorates = false,
    this.isLoadingCities = false,
    this.isSavingAddress = false,
    this.isFetchingCurrentLocation = false,
    this.isFetchingAddressFromLocation = false,
    this.governorates = const [],
    this.allCities = const [],
    this.filteredCities = const [],
    this.selectedGovernorate,
    this.selectedCity,
    this.latitude,
    this.longitude,
    this.currentDeviceLatitude,
    this.currentDeviceLongitude,
    this.governorateName = "",
    this.cityName = "",
    this.address,
    this.errorMessage = "",
  });

  AddressDetailsBaseState copyWith({
    bool? isLoadingGovernorates,
    bool? isLoadingCities,
    bool? isSavingAddress,
    bool? isFetchingCurrentLocation,
    bool? isFetchingAddressFromLocation,
    List<GovernorateModel>? governorates,
    List<CityModel>? allCities,
    List<CityModel>? filteredCities,
    Object? selectedGovernorate = _noChange,
    Object? selectedCity = _noChange,
    double? latitude,
    double? longitude,
    double? currentDeviceLatitude,
    double? currentDeviceLongitude,
    String? governorateName,
    String? cityName,
    AddressDetailsEntity? address,
    String? errorMessage,
  }) {
    return AddressDetailsBaseState(
      isLoadingGovernorates:
          isLoadingGovernorates ?? this.isLoadingGovernorates,
      isLoadingCities: isLoadingCities ?? this.isLoadingCities,
      isSavingAddress: isSavingAddress ?? this.isSavingAddress,
      isFetchingCurrentLocation:
          isFetchingCurrentLocation ?? this.isFetchingCurrentLocation,
      isFetchingAddressFromLocation:
          isFetchingAddressFromLocation ?? this.isFetchingAddressFromLocation,
      governorates: governorates ?? this.governorates,
      allCities: allCities ?? this.allCities,
      filteredCities: filteredCities ?? this.filteredCities,
      selectedGovernorate: selectedGovernorate == _noChange
          ? this.selectedGovernorate
          : selectedGovernorate as GovernorateModel?,
      selectedCity: selectedCity == _noChange
          ? this.selectedCity
          : selectedCity as CityModel?,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      currentDeviceLatitude:
          currentDeviceLatitude ?? this.currentDeviceLatitude,
      currentDeviceLongitude:
          currentDeviceLongitude ?? this.currentDeviceLongitude,
      governorateName: governorateName ?? this.governorateName,
      cityName: cityName ?? this.cityName,
      address: address ?? this.address,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingGovernorates,
    isLoadingCities,
    isSavingAddress,
    isFetchingCurrentLocation,
    isFetchingAddressFromLocation,
    governorates,
    allCities,
    filteredCities,
    selectedGovernorate,
    selectedCity,
    latitude,
    longitude,
    currentDeviceLatitude,
    currentDeviceLongitude,
    governorateName,
    cityName,
    address,
    errorMessage,
  ];
}
