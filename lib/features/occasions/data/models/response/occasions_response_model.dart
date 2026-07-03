import 'package:flowery/core/const/occasions_values.dart';
import 'package:flowery/features/occasions/data/models/response/meta_data_model.dart';
import 'package:flowery/features/occasions/data/models/response/occasion_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'occasions_response_model.g.dart';

@JsonSerializable()
class OccasionsResponseModel {
  @JsonKey(name: OccasionsValues.message)
  String? message;
  @JsonKey(name: OccasionsValues.metadata)
  Metadata? metadata;
  @JsonKey(name: OccasionsValues.occasions)
  List<Occasion>? occasions;

  OccasionsResponseModel({
    required this.message,
    required this.metadata,
    required this.occasions,
  });

  factory OccasionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionsResponseModelToJson(this);
}

OccasionsResponseModel occasionsResponseModelFromJson(String str) =>
    OccasionsResponseModel.fromJson(json.decode(str));

String occasionsResponseModelToJson(OccasionsResponseModel data) =>
    json.encode(data.toJson());
