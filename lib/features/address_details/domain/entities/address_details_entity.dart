import 'package:equatable/equatable.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';

class AddressDetailsEntity extends Equatable {
  final String? message;
  final List<AddressDetailsDtoEntity>? address;

  const AddressDetailsEntity({
    this.message,
    this.address,
  });

  @override
  List<Object?> get props => [message, address];
}