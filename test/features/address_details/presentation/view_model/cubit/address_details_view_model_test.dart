import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/use_case/address_details_use_case.dart';
import 'package:flowery/features/address_details/domain/use_case/delete_address_use_case.dart';
import 'package:flowery/features/address_details/presentation/view_model/cubit/address_details_view_model.dart';
import 'package:flowery/features/address_details/presentation/view_model/events/address_details_events.dart';
import 'package:flowery/features/address_details/presentation/view_model/states/address_details_base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressDetailsUseCase extends Mock implements AddressDetailsUseCase {}

class MockDeleteAddressUseCase extends Mock implements DeleteAddressUseCase {}

void main() {
  late AddressDetailsViewModel viewModel;
  late MockAddressDetailsUseCase mockAddressDetailsUseCase;
  late MockDeleteAddressUseCase mockDeleteAddressUseCase;

  final errorMessage = "An error has occured";

  late AddressDetailsRequest request;
  late AddressDetailsEntity entity;

  late GovernorateModel governorate1;
  late GovernorateModel governorate2;
  late CityModel city1;
  late CityModel city2;
  late CityModel city3;
  late List<GovernorateModel> governorates;
  late List<CityModel> allCities;

  setUpAll(() {
    registerFallbackValue(
      AddressDetailsRequest(
        street: "",
        phone: "",
        city: "",
        lat: "",
        long: "",
        username: "",
      ),
    );
  });

  setUp(() {
    mockAddressDetailsUseCase = MockAddressDetailsUseCase();
    mockDeleteAddressUseCase = MockDeleteAddressUseCase();
    viewModel = AddressDetailsViewModel(
      mockAddressDetailsUseCase,
      mockDeleteAddressUseCase,
    );

    request = AddressDetailsRequest(
      street: "street",
      phone: "01000000000",
      city: "city",
      lat: "30.0",
      long: "31.0",
      username: "username",
    );

    entity = const AddressDetailsEntity(
      message: "success",
      address: [
        AddressDetailsDtoEntity(
          street: "street",
          phone: "01000000000",
          city: "city",
          lat: "30.0",
          long: "31.0",
          username: "username",
          id: "addressId1",
        ),
      ],
    );

    governorate1 = GovernorateModel(id: "gov1", nameAr: "القاهرة", nameEn: "Cairo");
    governorate2 = GovernorateModel(id: "gov2", nameAr: "الجيزة", nameEn: "Giza");
    governorates = [governorate1, governorate2];

    city1 = CityModel(id: "city1", governorateId: "gov1", nameAr: "مدينة نصر", nameEn: "Nasr City");
    city2 = CityModel(id: "city2", governorateId: "gov1", nameAr: "مصر الجديدة", nameEn: "Heliopolis");
    city3 = CityModel(id: "city3", governorateId: "gov2", nameAr: "الدقي", nameEn: "Dokki");
    allCities = [city1, city2, city3];
  });

  group("Testing updating the selected location", () {
    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Updating latitude, longitude, governorate and city names",

      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          UpdateLocationEvent(
            latitude: 30.0,
            longitude: 31.0,
            governorateName: "Cairo",
            cityName: "Nasr City",
          ),
        );
      },

      // Assert
      expect: () => [
        const AddressDetailsBaseState(
          latitude: 30.0,
          longitude: 31.0,
          governorateName: "Cairo",
          cityName: "Nasr City",
        ),
      ],
    );
  });

  group("Testing selecting a governorate", () {
    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Selecting a governorate filters its cities and resets selected city",

      build: () => viewModel,
      seed: () => AddressDetailsBaseState(
        governorates: governorates,
        allCities: allCities,
        selectedCity: city3,
      ),

      // Act
      act: (viewModel) {
        viewModel.doEvent(SelectGovernorateEvent(governorate1));
      },

      // Assert
      expect: () => [
        AddressDetailsBaseState(
          governorates: governorates,
          allCities: allCities,
          selectedGovernorate: governorate1,
          filteredCities: [city1, city2],
          selectedCity: null,
        ),
      ],
    );

    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Selecting a governorate with no matching cities returns an empty filtered list",

      build: () => viewModel,
      seed: () => AddressDetailsBaseState(
        governorates: governorates,
        allCities: const [],
      ),

      // Act
      act: (viewModel) {
        viewModel.doEvent(SelectGovernorateEvent(governorate2));
      },

      // Assert
      expect: () => [
        AddressDetailsBaseState(
          governorates: governorates,
          allCities: const [],
          selectedGovernorate: governorate2,
          filteredCities: const [],
          selectedCity: null,
        ),
      ],
    );
  });

  group("Testing selecting a city", () {
    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Selecting a city updates the selected city",

      build: () => viewModel,
      seed: () => AddressDetailsBaseState(
        governorates: governorates,
        filteredCities: [city1, city2],
      ),

      // Act
      act: (viewModel) {
        viewModel.doEvent(SelectCityEvent(city2));
      },

      // Assert
      expect: () => [
        AddressDetailsBaseState(
          governorates: governorates,
          filteredCities: [city1, city2],
          selectedCity: city2,
        ),
      ],
    );
  });

  group("Testing saving a new address", () {
    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Success in saving a new address",

      // Arrange
      setUp: () {
        when(() => mockAddressDetailsUseCase.call(request)).thenAnswer(
          (_) async => Success<AddressDetailsEntity>(data: entity),
        );
      },
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(SaveAddressDetailsEvent(), request: request);
      },

      // Assert
      expect: () => [
        const AddressDetailsBaseState(isSavingAddress: true),
        AddressDetailsBaseState(isSavingAddress: false, address: entity),
      ],

      verify: (_) {
        verify(() => mockAddressDetailsUseCase.call(request)).called(1);
        verifyNever(() => mockDeleteAddressUseCase.call(any()));
      },
    );

    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Error saving a new address",

      // Arrange
      setUp: () {
        when(() => mockAddressDetailsUseCase.call(request)).thenAnswer(
          (_) async =>
              Error<AddressDetailsEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(SaveAddressDetailsEvent(), request: request);
      },

      // Assert
      expect: () => [
        const AddressDetailsBaseState(isSavingAddress: true),
        AddressDetailsBaseState(
          isSavingAddress: false,
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockAddressDetailsUseCase.call(request)).called(1);
      },
    );
  });

  group("Testing updating (editing) an existing address", () {
    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Success deleting the old address then saving the new one",

      // Arrange
      setUp: () {
        when(() => mockDeleteAddressUseCase.call("addressId1")).thenAnswer(
          (_) async => Success<AddressDetailsEntity>(data: entity),
        );
        when(() => mockAddressDetailsUseCase.call(request)).thenAnswer(
          (_) async => Success<AddressDetailsEntity>(data: entity),
        );
      },
      build: () => viewModel,
      seed: () => const AddressDetailsBaseState(editingAddressId: "addressId1"),

      // Act
      act: (viewModel) {
        viewModel.doEvent(SaveAddressDetailsEvent(), request: request);
      },

      // Assert
      expect: () => [
        const AddressDetailsBaseState(
          editingAddressId: "addressId1",
          isSavingAddress: true,
        ),
        AddressDetailsBaseState(
          editingAddressId: "addressId1",
          isSavingAddress: false,
          address: entity,
        ),
      ],

      verify: (_) {
        verify(() => mockDeleteAddressUseCase.call("addressId1")).called(1);
        verify(() => mockAddressDetailsUseCase.call(request)).called(1);
      },
    );

    blocTest<AddressDetailsViewModel, AddressDetailsBaseState>(
      "Error deleting the old address stops the update (new address not sent)",

      // Arrange
      setUp: () {
        when(() => mockDeleteAddressUseCase.call("addressId1")).thenAnswer(
          (_) async =>
              Error<AddressDetailsEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () => viewModel,
      seed: () => const AddressDetailsBaseState(editingAddressId: "addressId1"),

      // Act
      act: (viewModel) {
        viewModel.doEvent(SaveAddressDetailsEvent(), request: request);
      },

      // Assert
      expect: () => [
        const AddressDetailsBaseState(
          editingAddressId: "addressId1",
          isSavingAddress: true,
        ),
        AddressDetailsBaseState(
          editingAddressId: "addressId1",
          isSavingAddress: false,
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockDeleteAddressUseCase.call("addressId1")).called(1);
        verifyNever(() => mockAddressDetailsUseCase.call(any()));
      },
    );
  });
}