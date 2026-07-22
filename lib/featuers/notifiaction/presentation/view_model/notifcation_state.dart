import 'package:flowery/config/base_state/base_state.dart';
import '../../domain/entity/notifcation_entity.dart';

import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final BaseState<List<NotificationEntity>> notificationsState;

  const NotificationState({
    this.notificationsState = const BaseState.initial(),
  });

  NotificationState copyWith({
    BaseState<List<NotificationEntity>>? notificationsState,
  }) {
    return NotificationState(
      notificationsState:
      notificationsState ?? this.notificationsState,
    );
  }

  @override
  List<Object?> get props => [notificationsState];
}