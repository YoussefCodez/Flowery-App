import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';

abstract interface class LoginRepoContract {
  Future<Result<LoginUserEntity>> login(String email, String password);
}
