// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseModel _$NotificationResponseModelFromJson(
  Map<String, dynamic> json,
) => NotificationResponseModel(
  title: json['title'] as String?,
  body: json['body'] as String?,
  isRead: json['isRead'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$NotificationResponseModelToJson(
  NotificationResponseModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
  'isRead': instance.isRead,
  'createdAt': instance.createdAt,
};
