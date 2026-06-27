import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/general_cubit/address_view_model/cubit/address_status_cubit.dart';
import 'package:flowery/config/general_cubit/address_view_model/events/address_status_events.dart';
import 'package:flowery/config/general_cubit/address_view_model/states/address_status_state.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/use_case/delete_address_use_case.dart';
import 'package:flowery/features/address_details/domain/use_case/get_saved_addresses_use_case.dart';
import 'package:flowery/features/save_address/presentation/view_model/cubit/saved_addresses_view_model.dart';
import 'package:flowery/features/save_address/presentation/view_model/events/saved_addresses_events.dart';
import 'package:flowery/features/save_address/presentation/view_model/states/saved_addresses_base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetSavedAddressesUseCase extends Mock
    implements GetSavedAddressesUseCase {}

class MockDeleteAddressUseCase extends Mock implements DeleteAddressUseCase {}

class MockAddressStatusCubit extends MockCubit<AddressStatusState>
    implements AddressStatusCubit {}

void main() {
  late SavedAddressesViewModel viewModel;
  late MockGetSavedAddressesUseCase mockGetSavedAddressesUseCase;
  late MockDeleteAddressUseCase mockDeleteAddressUseCase;
  late MockAddressStatusCubit mockAddressStatusCubit;

  final errorMessage = "An error has occured";

  late List<AddressDetailsDtoEntity> addresses;
  late AddressDetailsEntity addressesEntity;
  late AddressDetailsEntity addressesEntityAfterDelete;

  setUpAll(() {
    registerFallbackValue(CheckAddressStatusEvent());
  });

  setUp(() {
    mockGetSavedAddressesUseCase = MockGetSavedAddressesUseCase();
    mockDeleteAddressUseCase = MockDeleteAddressUseCase();
    mockAddressStatusCubit = MockAddressStatusCubit();

    when(() => mockAddressStatusCubit.doEvent(any())).thenAnswer((_) {});

    if (getIt.isRegistered<AddressStatusCubit>()) {
      getIt.unregister<AddressStatusCubit>();
    }
    getIt.registerSingleton<AddressStatusCubit>(mockAddressStatusCubit);

    viewModel = SavedAddressesViewModel(
      mockGetSavedAddressesUseCase,
      mockDeleteAddressUseCase,
    );

    addresses = const [
      AddressDetailsDtoEntity(
        street: "street1",
        phone: "01000000001",
        city: "city1",
        lat: "30.0",
        long: "31.0",
        username: "user1",
        id: "addressId1",
      ),
      AddressDetailsDtoEntity(
        street: "street2",
        phone: "01000000002",
        city: "city2",
        lat: "30.1",
        long: "31.1",
        username: "user2",
        id: "addressId2",
      ),
    ];

    addressesEntity = AddressDetailsEntity(
      message: "success",
      address: addresses,
    );

    addressesEntityAfterDelete = AddressDetailsEntity(
      message: "success",
      address: [addresses[1]],
    );
  });

  tearDown(() {
    if (getIt.isRegistered<AddressStatusCubit>()) {
      getIt.unregister<AddressStatusCubit>();
    }
  });

  group("Testing loading saved addresses", () {
    blocTest<SavedAddressesViewModel, SavedAddressesBaseState>(
      "Success in loading saved addresses",

      setUp: () {
        when(() => mockGetSavedAddressesUseCase.call()).thenAnswer(
          (_) async => Success<AddressDetailsEntity>(data: addressesEntity),
        );
      },
      build: () => viewModel,

      act: (viewModel) {
        viewModel.doEvent(LoadSavedAddressesEvent());
      },

      expect: () => [
        const SavedAddressesBaseState(isLoading: true),
        SavedAddressesBaseState(isLoading: false, addresses: addresses),
      ],

      verify: (_) {
        verify(() => mockGetSavedAddressesUseCase.call()).called(1);
      },
    );

    blocTest<SavedAddressesViewModel, SavedAddressesBaseState>(
      "Error loading saved addresses",

      setUp: () {
        when(() => mockGetSavedAddressesUseCase.call()).thenAnswer(
          (_) async =>
              Error<AddressDetailsEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () => viewModel,

      act: (viewModel) {
        viewModel.doEvent(LoadSavedAddressesEvent());
      },

      expect: () => [
        const SavedAddressesBaseState(isLoading: true),
        SavedAddressesBaseState(
          isLoading: false,
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockGetSavedAddressesUseCase.call()).called(1);
      },
    );
  });

  group("Testing deleting an address", () {
    blocTest<SavedAddressesViewModel, SavedAddressesBaseState>(
      "Success in deleting an address",

      setUp: () {
        when(() => mockDeleteAddressUseCase.call("addressId1")).thenAnswer(
          (_) async =>
              Success<AddressDetailsEntity>(data: addressesEntityAfterDelete),
        );
      },
      build: () => viewModel,

      act: (viewModel) {
        viewModel.doEvent(DeleteAddressEvent("addressId1"));
      },

      expect: () => [
        const SavedAddressesBaseState(
          isDeleting: true,
          deletingAddressId: "addressId1",
        ),
        SavedAddressesBaseState(
          isDeleting: false,
          deletingAddressId: null,
          addresses: [addresses[1]],
        ),
      ],

      verify: (_) {
        verify(() => mockDeleteAddressUseCase.call("addressId1")).called(1);
        verify(() => mockAddressStatusCubit.doEvent(any())).called(1);
      },
    );

    blocTest<SavedAddressesViewModel, SavedAddressesBaseState>(
      "Error deleting an address",

      setUp: () {
        when(() => mockDeleteAddressUseCase.call("addressId1")).thenAnswer(
          (_) async =>
              Error<AddressDetailsEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () => viewModel,

      act: (viewModel) {
        viewModel.doEvent(DeleteAddressEvent("addressId1"));
      },

      expect: () => [
        const SavedAddressesBaseState(
          isDeleting: true,
          deletingAddressId: "addressId1",
        ),
        SavedAddressesBaseState(
          isDeleting: false,
          deletingAddressId: null,
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockDeleteAddressUseCase.call("addressId1")).called(1);
        verifyNever(() => mockAddressStatusCubit.doEvent(any()));
      },
    );
  });
}
