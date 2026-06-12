import 'package:dio/src/form_data.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/data_sources/edit_profile_remote_data_sources_contract.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/repo/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepoContract)
class EditProfileRepoImpl implements EditProfileRepoContract {
  final EditProfileRemoteDataSourcesContract remoteDataSource;
  EditProfileRepoImpl({required this.remoteDataSource});

  @override
  Future<Result<UserEntity>> getLoggedUserInfo() async {
    final response = await remoteDataSource.getCurrentLoggedUser();

    switch (response) {
      case Success<GetUserResponseModel>():
        return Success<UserEntity>(data: response.data?.user?.toDomain());
      case Error<GetUserResponseModel>():
        return Error<UserEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<UserEntity>> editUserProfile({EditUserModel? editUser}) async {
    final response = await remoteDataSource.editUserProfile(editUser: editUser);

    switch (response) {
      case Success<GetUserResponseModel>():
        return Success<UserEntity>(data: response.data?.user?.toDomain());
      case Error<GetUserResponseModel>():
        return Error<UserEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<UserEntity>> uploadProfilePhoto({FormData? photo}) async{
    final response = await remoteDataSource.uploadUserPhoto(photo: photo);

    switch (response) {
      case Success<GetUserResponseModel>():
        return Success<UserEntity>(data: response.data?.user?.toDomain());
      case Error<GetUserResponseModel>():
        return Error<UserEntity>(exception: response.exception);
    }
  }
}
