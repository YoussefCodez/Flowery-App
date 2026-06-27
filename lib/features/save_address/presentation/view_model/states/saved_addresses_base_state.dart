import 'package:equatable/equatable.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';

const _noChange = Object();

class SavedAddressesBaseState extends Equatable {
  final bool isLoading;
  final bool isDeleting;
  final String? deletingAddressId;
  final List<AddressDetailsDtoEntity> addresses;
  final String errorMessage;

  const SavedAddressesBaseState({
    this.isLoading = false,
    this.isDeleting = false,
    this.deletingAddressId,
    this.addresses = const [],
    this.errorMessage = "",
  });

  SavedAddressesBaseState copyWith({
    bool? isLoading,
    bool? isDeleting,
    Object? deletingAddressId = _noChange,
    List<AddressDetailsDtoEntity>? addresses,
    String? errorMessage,
  }) {
    return SavedAddressesBaseState(
      isLoading: isLoading ?? this.isLoading,
      isDeleting: isDeleting ?? this.isDeleting,
      deletingAddressId: deletingAddressId == _noChange
          ? this.deletingAddressId
          : deletingAddressId as String?,
      addresses: addresses ?? this.addresses,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isDeleting, deletingAddressId, addresses, errorMessage];
}