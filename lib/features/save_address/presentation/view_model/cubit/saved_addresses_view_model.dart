import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/general_cubit/address_view_model/cubit/address_status_cubit.dart';
import 'package:flowery/config/general_cubit/address_view_model/events/address_status_events.dart';

import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/use_case/delete_address_use_case.dart';
import 'package:flowery/features/address_details/domain/use_case/get_saved_addresses_use_case.dart';
import 'package:flowery/features/save_address/presentation/view_model/events/saved_addresses_events.dart';
import 'package:flowery/features/save_address/presentation/view_model/states/saved_addresses_base_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedAddressesViewModel extends Cubit<SavedAddressesBaseState> {
  final GetSavedAddressesUseCase _getSavedAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  SavedAddressesViewModel(
    this._getSavedAddressesUseCase,
    this._deleteAddressUseCase,
  ) : super(const SavedAddressesBaseState());

  void doEvent(SavedAddressesEvents event) {
    switch (event) {
      case LoadSavedAddressesEvent():
        _loadAddresses();

      case DeleteAddressEvent():
        _deleteAddress(event.addressId);
    }
  }

  Future<void> _loadAddresses() async {
    emit(state.copyWith(isLoading: true, errorMessage: ""));

    final response = await _getSavedAddressesUseCase.call();

    switch (response) {
      case Success<AddressDetailsEntity>():
        emit(state.copyWith(isLoading: false, addresses: response.data?.address ?? []));

      case Error<AddressDetailsEntity>():
        emit(state.copyWith(isLoading: false, errorMessage: response.exception.toString()));
    }
  }

  Future<void> _deleteAddress(String addressId) async {
    emit(state.copyWith(isDeleting: true, deletingAddressId: addressId, errorMessage: ""));

    final response = await _deleteAddressUseCase.call(addressId);

    switch (response) {
      case Success<AddressDetailsEntity>():
        final updatedList = response.data?.address ?? [];
        emit(state.copyWith(isDeleting: false, deletingAddressId: null, addresses: updatedList));
        getIt<AddressStatusCubit>().doEvent(CheckAddressStatusEvent());

      case Error<AddressDetailsEntity>():
        emit(state.copyWith(isDeleting: false, deletingAddressId: null, errorMessage: response.exception.toString()));
    }
  }
}