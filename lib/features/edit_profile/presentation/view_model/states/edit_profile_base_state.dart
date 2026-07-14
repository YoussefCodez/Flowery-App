import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';

class EditProfileBaseState extends Equatable {
  final BaseState<UserEntity> getProfileState;
  final BaseState<UserEntity> updateProfileState;
  final BaseState<UserEntity> uploadNewPhotoState;

  const EditProfileBaseState({
    this.getProfileState = const BaseState.initial(),
    this.updateProfileState = const BaseState.initial(),
    this.uploadNewPhotoState = const BaseState.initial(),
  });

  EditProfileBaseState copyWith({
    BaseState<UserEntity>? getProfileState,
    BaseState<UserEntity>? updateProfileState,
    BaseState<UserEntity>? uploadNewPhotoState,
  }) {
    return EditProfileBaseState(
      getProfileState: getProfileState ?? this.getProfileState,
      updateProfileState: updateProfileState ?? this.updateProfileState,
      uploadNewPhotoState: uploadNewPhotoState ?? this.uploadNewPhotoState,
    );
  }

  @override
  List<Object?> get props => [
    getProfileState,
    updateProfileState,
    uploadNewPhotoState,
  ];
}
