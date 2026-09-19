import 'dart:convert';

import 'package:flowery/features/address_details/data/data_source/address_details_data_source_local_contract.dart';
import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDataSourceLocalContract)
class AddressLocalDataSourceImpl implements AddressDataSourceLocalContract {
  @override
  Future<List<GovernorateModel>> getGovernorates() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/cities.json',
    );

    final List data = jsonDecode(jsonString);

    final governoratesTable = data.firstWhere(
      (element) => element['name'] == 'governorates',
    );

    return (governoratesTable['data'] as List)
        .map((e) => GovernorateModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<CityModel>> getCities() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/states.json',
    );

    final List data = jsonDecode(jsonString);

    final citiesTable = data.firstWhere(
      (element) => element['name'] == 'cities',
    );

    return (citiesTable['data'] as List)
        .map((e) => CityModel.fromJson(e))
        .toList();
  }
}