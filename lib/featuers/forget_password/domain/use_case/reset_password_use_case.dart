import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/model/reqest_models/reset_password_request.dart';
import '../../data/model/response_model/reset_password_response.dart';
import '../repository/forget_password_repo_contract.dart';

@injectable
class ResetPasswordUseCase {
  ForgetPasswordRepoContract repo;

  ResetPasswordUseCase(this.repo);

  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) {
    return repo.resetPassword(request);
  }
}