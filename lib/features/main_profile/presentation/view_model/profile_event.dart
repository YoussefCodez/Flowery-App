sealed class ProfileEvent {}

class GetProfileDate extends ProfileEvent {}

class ToggleNotificationEvent extends ProfileEvent {
  final String userId;
  final bool value;

  ToggleNotificationEvent(this.userId,this.value);
}
