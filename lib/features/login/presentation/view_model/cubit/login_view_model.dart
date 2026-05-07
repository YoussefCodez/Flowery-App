import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/domain/use_cases/login_use_case.dart';
import 'package:flowery/features/login/presentation/view_model/events/login_events.dart';
import 'package:flowery/features/login/presentation/view_model/states/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase) : super(LoginInit());

  void doEvent(LoginEvents event, String email, String password) {
    switch (event) {
      case LoginUserEvent():
        loginEvent(email, password);
    }
  }

  Future<void> loginEvent(String email, String password) async {
    emit(LoginLoading());

    final response = await _loginUseCase.call(email, password);
    switch (response) {
      case Success():
        emit(LoginSuccess(response.data!));
      case Error():
        emit(LoginError(response.exception.toString()));
    }
  }
}
