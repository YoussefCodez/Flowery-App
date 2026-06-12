import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/repo/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadUserPhotoUseCase {
  final EditProfileRepoContract repo;
  UploadUserPhotoUseCase({required this.repo});

  Future<Result<UserEntity>> call(FormData? photo) {
    return repo.uploadProfilePhoto(photo: photo);
  }
}
