// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsResponseModel _$OccasionsResponseModelFromJson(
  Map<String, dynamic> json,
) => OccasionsResponseModel(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  occasions: (json['occasions'] as List<dynamic>?)
      ?.map((e) => Occasion.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OccasionsResponseModelToJson(
  OccasionsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'occasions': instance.occasions,
};
