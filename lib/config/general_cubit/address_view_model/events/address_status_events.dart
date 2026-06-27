import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';

sealed class AddressStatusEvents {}

class CheckAddressStatusEvent extends AddressStatusEvents {}
class SelectAddressEvent extends AddressStatusEvents {
  final AddressDetailsDtoEntity address;
  SelectAddressEvent(this.address);
}