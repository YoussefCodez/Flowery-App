import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/notifcation_entity.dart';

part 'notification_response_model.g.dart';

@JsonSerializable()
class NotificationResponseModel {
  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "body")
  final String? body;

  @JsonKey(name: "isRead")
  final bool? isRead;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  const NotificationResponseModel({
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NotificationResponseModelToJson(this);

  NotificationEntity toDomain() {
    return NotificationEntity(
      title: title,
      body: body,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}