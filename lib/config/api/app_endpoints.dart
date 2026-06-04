abstract class AppEndPoints {
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String getLoggedUserData = "auth/profile-data";
  static const String editUserProfile = "auth/editProfile";
  static const String uploadPhoto = "auth/upload-photo";
}
