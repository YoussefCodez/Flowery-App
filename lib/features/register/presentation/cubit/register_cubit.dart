import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/domain/use_case/register_use_case.dart';
import 'package:flowery/features/register/presentation/cubit/register_events.dart';
import 'package:flowery/features/register/presentation/cubit/register_states.dart';
import 'package:injectable/injectable.dart';

sealed class RegisterUiEvent {}

class ShowRegisterLoading extends RegisterUiEvent {}

class ShowRegisterError extends RegisterUiEvent {
  final String message;
  ShowRegisterError(this.message);
}

class NavigateToLogin extends RegisterUiEvent {}

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUseCase _registerUseCase;

  final _uiEventsController = StreamController<RegisterUiEvent>.broadcast();
  Stream<RegisterUiEvent> get uiEvents => _uiEventsController.stream;

  RegisterCubit(this._registerUseCase) : super(const RegisterStates());

  void doIntent(RegisterEvent event) {
    switch (event) {
      case GenderChanged():
        _onGenderChanged(event);
      case ToggleTermsAccepted():
        _onToggleTerms();
      case TogglePasswordVisibility():
        _onTogglePasswordVisibility();
      case ToggleConfirmPasswordVisibility():
        _onToggleConfirmPasswordVisibility();
      case SignUpButtonPressed():
        _onSignUpPressed(event);
    }
  }

  void _onGenderChanged(GenderChanged event) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onToggleTerms() {
    emit(state.copyWith(isTermsAccepted: !state.isTermsAccepted));
  }

  void _onTogglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  Future<void> _onSignUpPressed(SignUpButtonPressed event) async {
    // if (!state.isTermsAccepted) return;

    _uiEventsController.add(ShowRegisterLoading());

    final result = await _registerUseCase.call(
      RegisterRequestModel(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        rePassword: event.confirmPassword,
        phone: '+2${event.phoneNumber}',
        gender: event.gender,
      ),
    );

    result.when(
      success: (_) {
        _uiEventsController.add(NavigateToLogin());
      },
      error: (exception) {
        _uiEventsController.add(
          ShowRegisterError(exception?.toString() ?? 'Unknown error'),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}
