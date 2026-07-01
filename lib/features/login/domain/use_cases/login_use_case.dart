import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:flowery/features/login/domain/repo/login_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepoContract repo;
  LoginUseCase({required this.repo});

  Future<Result<LoginUserEntity>> call(String email, String password) async {
    return await repo.login(email, password);
  }
}
