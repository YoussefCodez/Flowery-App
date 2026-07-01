import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/model/reqest_models/verify_reset_password_request.dart';
import '../../data/model/response_model/verify_email_response.dart';
import '../repository/forget_password_repo_contract.dart';

@injectable
class VerifyEmailUseCase {
  ForgetPasswordRepoContract repo;

  VerifyEmailUseCase(this.repo);

  Future<Result<VerifyEmailResponse>> verifyEmail(
      VerifyResetPasswordRequest request,
      ) {
    return repo.verifyEmail(request);
  }
}