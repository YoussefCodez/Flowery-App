abstract class AppEndPoints {
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String register = 'auth/signup';
  static const String forgetPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetPassword = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String login = 'auth/signin';
}
