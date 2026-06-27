import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/general_cubit/address_view_model/events/address_status_events.dart';
import 'package:flowery/config/general_cubit/address_view_model/states/address_status_state.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flowery/features/address_details/domain/use_case/get_saved_addresses_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class AddressStatusCubit extends Cubit<AddressStatusState> {
  final GetSavedAddressesUseCase _getSavedAddressesUseCase;

  AddressStatusCubit(this._getSavedAddressesUseCase)
      : super(const AddressStatusState());

  void doEvent(AddressStatusEvents event) {
    switch (event) {
      case CheckAddressStatusEvent():
        _checkAddressStatus();

      case SelectAddressEvent():
        emit(state.copyWith(selectedAddress: event.address));
    }
  }

  Future<void> _checkAddressStatus() async {
    emit(state.copyWith(isLoading: true, errorMessage: ""));

    final response = await _getSavedAddressesUseCase.call();

    switch (response) {
      case Success<AddressDetailsEntity>():
        final addresses = response.data?.address ?? [];

        final stillExists = state.selectedAddress != null &&
            addresses.any((a) => a.id == state.selectedAddress!.id);

        emit(state.copyWith(
          isLoading: false,
          addresses: addresses,
          selectedAddress: stillExists ? state.selectedAddress : null,
        ));

      case Error<AddressDetailsEntity>():
        emit(state.copyWith(isLoading: false, errorMessage: response.exception.toString()));
    }
  }
}