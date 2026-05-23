abstract class AppEndPoints {
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String occasions = 'occasions';
  static const String occasion = 'occasion';
  static const String products = 'products';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String bestSeller = 'best-seller';

  static const String register = 'auth/signup';

  static const String forgetPassword = 'auth/forgotPassword';
  static const String verifyResetPassword = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
  
  static const String login = 'auth/signin';
  static const String categories = 'categories';
  static const String getHomeData = 'home';
  static const String getProduct = "products";
  static const String cart = 'cart';
}
