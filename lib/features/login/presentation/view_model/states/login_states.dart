import 'package:flowery/features/login/domain/entities/login_user_entity.dart';

sealed class LoginStates {}

class LoginInitState extends LoginStates {
  bool rememberMe;

  LoginInitState({this.rememberMe = false});
}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginUserEntity user;
  LoginSuccessState(this.user);
}

class LoginErrorState extends LoginStates {
  final String message;
  LoginErrorState(this.message);
}
