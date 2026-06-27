import 'package:json_annotation/json_annotation.dart';

part 'address_details_request.g.dart';


@JsonSerializable()
class AddressDetailsRequest {
    @JsonKey(name: "street")
    String? street;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "city")
    String? city;
    @JsonKey(name: "lat")
    String? lat;
    @JsonKey(name: "long")
    String? long;
    @JsonKey(name: "username")
    String? username;

    AddressDetailsRequest({
        this.street,
        this.phone,
        this.city,
        this.lat,
        this.long,
        this.username,
    });

    factory AddressDetailsRequest.fromJson(Map<String, dynamic> json) => _$AddressDetailsRequestFromJson(json);

    Map<String, dynamic> toJson() => _$AddressDetailsRequestToJson(this);
}
