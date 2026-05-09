import 'package:flowery/features/login/domain/entities/login_user_entity.dart';

sealed class LoginStates {}

class LoginInit extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final LoginUserEntity user;
  LoginSuccess(this.user);
}

class LoginError extends LoginStates {
  final String message;
  LoginError(this.message);
}
