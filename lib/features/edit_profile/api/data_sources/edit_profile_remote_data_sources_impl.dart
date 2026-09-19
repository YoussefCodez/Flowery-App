import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/handle_errors.dart';
import 'package:flowery/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flowery/features/edit_profile/data/data_sources/edit_profile_remote_data_sources_contract.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSourcesContract)
class EditProfileRemoteDataSourcesImpl
    implements EditProfileRemoteDataSourcesContract {
  final EditProfileApiClient apiClient;

  EditProfileRemoteDataSourcesImpl({required this.apiClient});

  @override
  Future<Result<GetUserResponseModel>> getCurrentLoggedUser() async {
    try {
      final response = await apiClient.getCurrentUser();

      return Success<GetUserResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<GetUserResponseModel>(
        exception: Exception(handleError(e, null)),
      );
    }
  }

  @override
  Future<Result<GetUserResponseModel>> editUserProfile(
    EditUserModel editUser,
  ) async {
    try {
      final response = await apiClient.editCurrentUserProfile(
        newEdits: editUser,
      );
      return Success<GetUserResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<GetUserResponseModel>(
        exception: Exception(handleError(e, null)),
      );
    }
  }

  @override
  Future<Result<GetUserResponseModel>> uploadUserPhoto(File photo) async {
    try {
      final response = await apiClient.uploadPhoto(photo);
      return Success<GetUserResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<GetUserResponseModel>(
        exception: Exception(handleError(e, null)),
      );
    }
  }
}
