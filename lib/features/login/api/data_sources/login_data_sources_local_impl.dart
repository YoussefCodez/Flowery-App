import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_local_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginDataSourcesLocalContract)
class LoginDataSourcesLocalImpl implements LoginDataSourcesLocalContract {
  final FlutterSecureStorage flutterSecureStorage;

  LoginDataSourcesLocalImpl({required this.flutterSecureStorage});

  @override
  Future<void> saveToken(String? token) async {
    if (token != null) {
      await flutterSecureStorage.write(key: Apikeys.accessToken, value: token);
    }
  }

  @override
  Future<String?> getToken() async {
    return await flutterSecureStorage.read(key: Apikeys.accessToken);
  }
}
