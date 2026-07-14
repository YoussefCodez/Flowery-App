/// Application-wide constants used across the project.
abstract class AppConstants {
  // 🔹 Shared Preferences Keys
  static const String token = 'token';
  static const String isTokenSaved = 'isTokenSaved';
  static const String isRemember = 'isRemember';
  static const String userRole = 'userRole';
  static const String userName = 'userName';
  static const String userEmail = 'userEmail';

  // 🔹 Localization Keys
  static const String languageCode = 'languageCode';
  static const String arKey = 'ar';
  static const String enKey = 'en';

  // 🔹 darkAndLight Keys

  static const String isDark = 'false';

  // 🔹 General Constants
  static const String noInternet = 'No Internet Connection';
  static const int animateSeconds = 300;
  static const double blurSigma = 10;
  static const String helpContentKey = "help_screen_content";
  static const String privacyPolicyContentKey = "privacy_policy";
  static const String securityRolesContentKey = "security_roles_config";

  static const String signUpScreenName = 'Sign up';
  static const String firstName = 'First name';
  static const String lastName = 'Last name';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String phoneNumber = 'Phone number';
  static const String confirmPassword = 'Confierm password';
  static const String femaleValue = 'female';
  static const String maleValue = 'male';

  static const String accountCreatedSuccessfully =
      'account created successfully';
}