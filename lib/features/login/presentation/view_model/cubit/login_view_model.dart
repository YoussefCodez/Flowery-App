import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/domain/use_cases/login_use_case.dart';
import 'package:flowery/features/login/presentation/view_model/events/login_events.dart';
import 'package:flowery/features/login/presentation/view_model/states/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase) : super(LoginInitState());

  void doEvent(LoginEvents event, {String? email, String? password, bool? currentBooleanRememberMe}) {
    switch (event) {
      case LoginUserEvent():
        _loginUserEvent(email!, password!);
      case ToggleRememberMeEvent():
        _toggleRememberMe(currentBooleanRememberMe!);
    }
  }

  Future<void> _loginUserEvent(String email, String password) async {
    emit(LoginLoadingState());

    final response = await _loginUseCase.call(email, password);
    switch (response) {
      case Success():
        emit(LoginSuccessState(response.data!));
      case Error():
        emit(LoginErrorState(response.exception.toString()));
    }
  }

  void _toggleRememberMe(bool currentBooleanRememberMe) {
    emit(LoginInitState(rememberMe: currentBooleanRememberMe));
  }
}
