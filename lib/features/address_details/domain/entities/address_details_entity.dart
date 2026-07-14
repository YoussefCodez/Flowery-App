import 'package:equatable/equatable.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';

class AddressDetailsResponseEntity extends Equatable {
  final String? message;
  final List<AddressEntity>? address;

  const AddressDetailsResponseEntity({this.message, this.address});

  @override
  List<Object?> get props => [message, address];
}
