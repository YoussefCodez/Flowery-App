import 'package:equatable/equatable.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';

const _noChange = Object();

class AddressStatusState extends Equatable {
  final bool isLoading;
  final List<AddressDetailsDtoEntity> addresses;
  final AddressDetailsDtoEntity? selectedAddress;
  final String errorMessage;

  const AddressStatusState({
    this.isLoading = false,
    this.addresses = const [],
    this.selectedAddress,
    this.errorMessage = "",
  });

  bool get hasAddress => addresses.isNotEmpty;

  AddressDetailsDtoEntity? get currentAddress =>
      selectedAddress ?? (addresses.isNotEmpty ? addresses.last : null);

  AddressStatusState copyWith({
    bool? isLoading,
    List<AddressDetailsDtoEntity>? addresses,
    Object? selectedAddress = _noChange,
    String? errorMessage,
  }) {
    return AddressStatusState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress == _noChange
          ? this.selectedAddress
          : selectedAddress as AddressDetailsDtoEntity?,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, addresses, selectedAddress, errorMessage];
}