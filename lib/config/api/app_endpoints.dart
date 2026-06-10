abstract class AppEndPoints {
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String occasions = 'occasions';
  static const String occasion = 'occasion';
  static const String products = 'products';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
  static const String forgetPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetPassword = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String getHomeData = 'home';
  static const String categories = 'categories';
  static const String bestSeller = 'best-seller';
  static const String cart = 'cart';
  static const String getProduct = "products";
}
