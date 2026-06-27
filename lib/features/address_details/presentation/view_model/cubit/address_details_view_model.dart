import 'dart:convert';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/use_case/address_details_use_case.dart';
import 'package:flowery/features/address_details/domain/use_case/delete_address_use_case.dart';
import 'package:flowery/features/address_details/presentation/view_model/events/address_details_events.dart';
import 'package:flowery/features/address_details/presentation/view_model/states/address_details_base_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDetailsViewModel extends Cubit<AddressDetailsBaseState> {
  final AddressDetailsUseCase _addressDetailsUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  AddressDetailsViewModel(
    this._addressDetailsUseCase,
    this._deleteAddressUseCase,
  ) : super(const AddressDetailsBaseState());

  void doEvent(AddressDetailsEvents event, {AddressDetailsRequest? request}) {
    switch (event) {
      case LoadGovernoratesEvent():
        _loadGovernorates();

      case LoadCitiesEvent():
        _loadCities();

      case SelectGovernorateEvent():
        _selectGovernorate(event.governorate);

      case SelectCityEvent():
        _selectCity(event.city);

      case UpdateLocationEvent():
        _updateLocation(event);

      case GetCurrentDeviceLocationEvent():
        _getCurrentDeviceLocation();

      case SelectLocationOnMapEvent():
        _selectLocationOnMap(event.latitude, event.longitude);

      case LoadAddressForEditEvent():
        _loadAddressForEdit(event.address);

      case SaveAddressDetailsEvent():
        if (request != null) {
          _saveAddress(request);
        }
    }
  }

  String _normalizeArabic(String input) {
    return input
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll(RegExp(r'\s+'), '')
        .trim();
  }

  Future<void> _loadGovernorates() async {
    emit(state.copyWith(isLoadingGovernorates: true));
    try {
      final jsonString = await rootBundle.loadString('assets/json/cities.json');
      final List data = jsonDecode(jsonString);
      final governoratesTable =
          data.firstWhere((element) => element['name'] == 'governorates');
      final governorates = (governoratesTable['data'] as List)
          .map((e) => GovernorateModel.fromJson(e))
          .toList();

      emit(state.copyWith(isLoadingGovernorates: false, governorates: governorates));
    } catch (e) {
      emit(state.copyWith(isLoadingGovernorates: false, errorMessage: e.toString()));
    }
  }

  Future<void> _loadCities() async {
    emit(state.copyWith(isLoadingCities: true));
    try {
      final jsonString = await rootBundle.loadString('assets/json/states.json');
      final List data = jsonDecode(jsonString);
      final citiesTable = data.firstWhere((element) => element['name'] == 'cities');
      final cities = (citiesTable['data'] as List)
          .map((e) => CityModel.fromJson(e))
          .toList();

      emit(state.copyWith(isLoadingCities: false, allCities: cities));
    } catch (e) {
      emit(state.copyWith(isLoadingCities: false, errorMessage: e.toString()));
    }
  }

  void _selectGovernorate(GovernorateModel governorate) {
    final filteredCities = state.allCities
        .where((city) => city.governorateId == governorate.id)
        .toList();

    emit(state.copyWith(
      selectedGovernorate: governorate,
      filteredCities: filteredCities,
      selectedCity: null,
    ));
  }

  void _selectCity(CityModel city) {
    emit(state.copyWith(selectedCity: city));
  }

  void _updateLocation(UpdateLocationEvent event) {
    emit(state.copyWith(
      latitude: event.latitude,
      longitude: event.longitude,
      governorateName: event.governorateName,
      cityName: event.cityName,
    ));
  }

  Future<void> _getCurrentDeviceLocation() async {
    emit(state.copyWith(isFetchingCurrentLocation: true));
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(isFetchingCurrentLocation: false));
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        emit(state.copyWith(isFetchingCurrentLocation: false));
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      emit(state.copyWith(
        isFetchingCurrentLocation: false,
        currentDeviceLatitude: position.latitude,
        currentDeviceLongitude: position.longitude,
      ));
    } catch (e) {
      emit(state.copyWith(isFetchingCurrentLocation: false, errorMessage: e.toString()));
    }
  }

  Future<void> _selectLocationOnMap(double latitude, double longitude) async {
    emit(state.copyWith(isFetchingAddressFromLocation: true));
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      final place = placemarks.first;
      final governorateName = (place.administrativeArea ?? '').replaceAll('محافظة ', '');
      final cityName = place.locality ?? '';

      GovernorateModel? matchedGovernorate;
      final normalizedGovernorateName = _normalizeArabic(governorateName);

      for (final g in state.governorates) {
        if (_normalizeArabic(g.nameAr) == normalizedGovernorateName) {
          matchedGovernorate = g;
          break;
        }
      }

      List<CityModel> filteredCities = state.filteredCities;
      CityModel? matchedCity;

      if (matchedGovernorate != null) {
        filteredCities = state.allCities
            .where((city) => city.governorateId == matchedGovernorate!.id)
            .toList();

        final normalizedCityName = _normalizeArabic(cityName);
        for (final c in filteredCities) {
          final normalizedCNameAr = _normalizeArabic(c.nameAr);
          if (normalizedCNameAr == normalizedCityName ||
              normalizedCNameAr.contains(normalizedCityName) ||
              normalizedCityName.contains(normalizedCNameAr)) {
            matchedCity = c;
            break;
          }
        }
      }

      emit(state.copyWith(
        isFetchingAddressFromLocation: false,
        latitude: latitude,
        longitude: longitude,
        governorateName: governorateName,
        cityName: cityName,
        selectedGovernorate: matchedGovernorate,
        filteredCities: filteredCities,
        selectedCity: matchedCity,
      ));
    } catch (e) {
      emit(state.copyWith(isFetchingAddressFromLocation: false, errorMessage: e.toString()));
    }
  }

  Future<void> _loadAddressForEdit(AddressDetailsDtoEntity address) async {
    await _loadGovernorates();
    await _loadCities();

    final cityName = address.city ?? '';
    final normalizedCityName = _normalizeArabic(cityName);

    CityModel? matchedCity;
    for (final c in state.allCities) {
      if (_normalizeArabic(c.nameAr) == normalizedCityName) {
        matchedCity = c;
        break;
      }
    }

    GovernorateModel? matchedGovernorate;
    List<CityModel> filteredCities = [];

    if (matchedCity != null) {
      for (final g in state.governorates) {
        if (g.id == matchedCity.governorateId) {
          matchedGovernorate = g;
          break;
        }
      }
      if (matchedGovernorate != null) {
        filteredCities = state.allCities
            .where((c) => c.governorateId == matchedGovernorate!.id)
            .toList();
      }
    }

    emit(state.copyWith(
      editingAddressId: address.id,
      selectedGovernorate: matchedGovernorate,
      filteredCities: filteredCities,
      selectedCity: matchedCity,
      latitude: double.tryParse(address.lat ?? ''),
      longitude: double.tryParse(address.long ?? ''),
      governorateName: matchedGovernorate?.nameAr ?? '',
      cityName: cityName,
    ));
  }

  Future<void> _saveAddress(AddressDetailsRequest request) async {
    emit(state.copyWith(isSavingAddress: true, errorMessage: ""));

    if (state.editingAddressId != null) {
      final deleteResponse = await _deleteAddressUseCase.call(state.editingAddressId!);
      if (deleteResponse is Error<AddressDetailsEntity>) {
        emit(state.copyWith(
          isSavingAddress: false,
          errorMessage: deleteResponse.exception.toString(),
        ));
        return;
      }
    }

    final response = await _addressDetailsUseCase.call(request);

    switch (response) {
      case Success<AddressDetailsEntity>():
        emit(state.copyWith(isSavingAddress: false, address: response.data));

      case Error<AddressDetailsEntity>():
        emit(state.copyWith(
          isSavingAddress: false,
          errorMessage: response.exception.toString(),
        ));
    }
  }
}