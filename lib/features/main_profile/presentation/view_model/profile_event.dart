sealed class ProfileEvent {}

class GetProfileDate extends ProfileEvent {}

class ToggleNotificationEvent extends ProfileEvent {
  final bool value;

  ToggleNotificationEvent({required this.value});
}
