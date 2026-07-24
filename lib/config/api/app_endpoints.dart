abstract class AppEndPoints {

  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String occasions = 'occasions';
  static const String products = 'products';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String logout = 'auth/logout';
  static const String login = 'auth/signin';
  static const String changePassword = "auth/change-password";
  static const String bestSeller = 'best-seller';
  static const String register = 'auth/signup';
  static const String cart = 'cart';
  static const String checkoutSession =
      "orders/checkout?url=http://localhost:3000";
  static const String createCashOrder = "orders";
  static const String getLoggedUserData = "auth/profile-data";
  static const String editUserProfile = "auth/editProfile";
  static const String uploadPhoto = "auth/upload-photo";
}
