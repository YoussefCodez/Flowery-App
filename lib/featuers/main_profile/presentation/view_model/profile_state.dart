import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/main_profile/domain/entity/profile_entity.dart';

class ProfileState extends Equatable {
  final BaseState<ProfileEntity> getProfileDate;

  const ProfileState({
    this.getProfileDate = const BaseState.initial(),
  });

  ProfileState copyWith({BaseState<ProfileEntity>? getProfileDatePram}) {
    return ProfileState(
      getProfileDate: getProfileDatePram ?? getProfileDate,
    );
  }

  @override
  List<Object?> get props => [getProfileDate];
}