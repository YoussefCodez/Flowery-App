import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';


class RegisterStates extends Equatable {
  // ── UI toggles ──────────────────────────────────────────────
  final String gender;
  final bool isTermsAccepted;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  // ── Async API state ─────────────────────────────────────────
  final BaseState<void> registerRequestState;

  const RegisterStates({
    this.gender = '',
    this.isTermsAccepted = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.registerRequestState = const BaseState<void>.initial(), 
  });

  RegisterStates copyWith({
    String? gender,
    bool? isTermsAccepted,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    BaseState<void>? registerRequestState,
  }) {
    return RegisterStates(
      gender: gender ?? this.gender,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      registerRequestState: registerRequestState ?? this.registerRequestState,
    );
  }

  @override
  List<Object?> get props => [
        gender,
        isTermsAccepted,
        isPasswordVisible,
        isConfirmPasswordVisible,
        registerRequestState,
      ];
}