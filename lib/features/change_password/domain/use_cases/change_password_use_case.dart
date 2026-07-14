import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:flowery/features/change_password/domain/repo/change_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepoContract repo;
  ChangePasswordUseCase(this.repo);

  Future<Result<ChangePasswordResponseModel>> call(
    String oldPassword,
    String newPassword,
  ) {
    return repo.changePassword(oldPassword, newPassword);
  }
}
