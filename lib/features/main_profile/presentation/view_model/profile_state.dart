import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';

class ProfileState {
  final BaseState<ProfileEntity> getProfileDate;
  final bool isNotificationOn;

  ProfileState({
    BaseState<ProfileEntity>? getProfileDate,
    this.isNotificationOn = false,
  }) : getProfileDate = getProfileDate ?? const BaseState.initial();

  ProfileState copyWith({
    BaseState<ProfileEntity>? getProfileDatePram,
    final bool? isNotificationOn,
  }) {
    return ProfileState(
      getProfileDate: getProfileDatePram ?? getProfileDate,
      isNotificationOn: isNotificationOn ?? this.isNotificationOn,
    );
  }
}
