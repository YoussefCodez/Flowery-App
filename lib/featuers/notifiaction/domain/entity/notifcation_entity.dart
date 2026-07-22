import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? title;
  final String? body;
  final bool? isRead;
  final String? createdAt;

  const NotificationEntity({
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    title,
    body,
    isRead,
    createdAt,
  ];
}