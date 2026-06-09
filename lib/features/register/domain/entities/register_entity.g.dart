// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterEntity _$RegisterEntityFromJson(Map<String, dynamic> json) =>
    RegisterEntity(
      message: json['message'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$RegisterEntityToJson(RegisterEntity instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'token': instance.token,
    };
