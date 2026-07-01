abstract interface class LoginDataSourcesLocalContract {
  Future<void> saveToken(String? token);

  Future<String?> getToken();
}
