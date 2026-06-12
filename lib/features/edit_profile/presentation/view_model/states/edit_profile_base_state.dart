import 'package:equatable/equatable.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

@immutable
class EditProfileBaseState extends Equatable {
  final bool? isLoadingProfile;

  final String? errorMessage;

  final UserEntity? user;

  const EditProfileBaseState({
    this.isLoadingProfile,
    this.errorMessage,
    this.user,
  });

  EditProfileBaseState copyWith({
    bool? isLoadingProfile,
    String? errorMessage,
    UserEntity? user,
    String? newGender,
  }) => EditProfileBaseState(
    isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
    errorMessage: errorMessage ?? this.errorMessage,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [isLoadingProfile, errorMessage, user];
}
