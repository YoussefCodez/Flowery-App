import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/repo/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateLoggedUserUseCase {
  final EditProfileRepoContract repo;
  UpdateLoggedUserUseCase({required this.repo});

  Future<Result<UserEntity>> call(EditUserModel editUser) {
    return repo.editUserProfile(editUser);
  }
}
