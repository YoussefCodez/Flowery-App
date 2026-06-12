import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';

abstract interface class EditProfileRemoteDataSourcesContract {
  Future<Result<GetUserResponseModel>> getCurrentLoggedUser();

  Future<Result<GetUserResponseModel>> editUserProfile({EditUserModel? editUser});

  Future<Result<GetUserResponseModel>> uploadUserPhoto({FormData? photo});
}
