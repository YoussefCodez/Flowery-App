import 'package:flowery/features/address_details/data/models/responce/address_details_dto_responce.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_addresses_responce.g.dart';

@JsonSerializable()
class GetAddressesResponce {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "addresses")
  List<AddressDto>? addresses;

  GetAddressesResponce({this.message, this.addresses});

  factory GetAddressesResponce.fromJson(Map<String, dynamic> json) =>
      _$GetAddressesResponceFromJson(json);

  Map<String, dynamic> toJson() => _$GetAddressesResponceToJson(this);

  AddressDetailsEntity toDomain() {
    return AddressDetailsEntity(
      message: message,
      address: addresses?.map((e) => e.toDomain()).toList(),
    );
  }
}