import 'package:flowery/features/address_details/data/models/responce/address_details_dto_responce.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_details_responce.g.dart';

@JsonSerializable()
class AddressDetailsResponce {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "address")
  List<AddressDto>? address;

  AddressDetailsResponce({this.message, this.address});

  factory AddressDetailsResponce.fromJson(Map<String, dynamic> json) =>
      _$AddressDetailsResponceFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailsResponceToJson(this);
  AddressDetailsEntity toDomain() {
    return AddressDetailsEntity(
      message: message,
      address: address?.map((e) => e.toDomain()).toList(),
    );
  }
}
