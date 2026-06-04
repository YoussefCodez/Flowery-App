import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';

abstract interface class EditProfileRepoContract {
  Future<Result<UserEntity>> getLoggedUserInfo();

  Future<Result<UserEntity>> editUserProfile({EditUserModel? editUser});

  Future<Result<UserEntity>> uploadProfilePhoto({FormData? photo});
}