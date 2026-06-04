import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/update_logged_user_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/upload_user_photo_use_case.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/states/edit_profile_base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileBaseState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final UpdateLoggedUserUseCase _updateLoggedUserUseCase;
  final UploadUserPhotoUseCase _uploadUserPhotoUseCase;
  EditProfileViewModel(
    this._getLoggedUserUseCase,
    this._updateLoggedUserUseCase,
    this._uploadUserPhotoUseCase,
  ) : super(EditProfileBaseState());

  void doEvent(
    EditProfileEvents event, {
    String? newGender,
    EditUserModel? user,
    FormData? photo,
  }) {
    switch (event) {
      case GetLoggedUserEvent():
        _getLoggedUser();
      case ChangeGenderEvent():
        _changeGender(newGender);
      case UpdateLoggedUserEvent():
        _updateLoggedUser(user);
      case UploadProfilePhotoEvent():
        _uploadPhoto(photo);
    }
  }

  void _changeGender(String? newGender) {
    emit(state.copyWith(newGender: newGender));
  }

  Future<void> _getLoggedUser() async {
    emit(state.copyWith(isLoadingProfile: true));

    final response = await _getLoggedUserUseCase.call();

    switch (response) {
      case Success<UserEntity>():
        emit(state.copyWith(isLoadingProfile: false, user: response.data));
      case Error<UserEntity>():
        emit(
          state.copyWith(
            isLoadingProfile: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  Future<void> _updateLoggedUser(EditUserModel? user) async {
    emit(state.copyWith(isLoadingProfile: true));

    final response = await _updateLoggedUserUseCase.call(user);

    switch (response) {
      case Success<UserEntity>():
        emit(state.copyWith(isLoadingProfile: false, user: response.data));
      case Error<UserEntity>():
        emit(
          state.copyWith(
            isLoadingProfile: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  Future<void> _uploadPhoto(FormData? photo) async {
    emit(state.copyWith(isLoadingProfile: true));

    final response = await _uploadUserPhotoUseCase.call(photo);

    switch (response) {
      case Success<UserEntity>():
        await _getLoggedUser();
      case Error<UserEntity>():
        emit(
          state.copyWith(
            isLoadingProfile: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }
}
