abstract class RegisterEvent {}

class SignUpButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String gender;

  SignUpButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.gender,
  });
}

class GenderChanged extends RegisterEvent {
  final String gender;
  GenderChanged(this.gender);
}

class ToggleTermsAccepted extends RegisterEvent {}

class TogglePasswordVisibility extends RegisterEvent {}

class ToggleConfirmPasswordVisibility extends RegisterEvent {}