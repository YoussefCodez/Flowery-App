import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/model/reqest_models/forget_password_request.dart';
import '../../data/model/response_model/forget_password_response.dart';
import '../repository/forget_password_repo_contract.dart';

@injectable
class ForgetPasswordUseCase {
  ForgetPasswordRepoContract repo;

  ForgetPasswordUseCase(this.repo);

  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request,
      ) {
    return repo.forgetPassword(request);
  }
}