import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_contract.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:flowery/features/login/domain/repo/login_repo_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  final LoginDataSourcesContract dataSources;
  LoginRepoImpl({required this.dataSources});

  @override
  Future<Result<LoginUserEntity>> login(String email, String password) async {
    final response = await dataSources.login(email, password);

    switch (response) {
      case Success<LoginResponseModel>():
        // Saving token
        final fss = getIt<FlutterSecureStorage>();
        await fss.write(key: Apikeys.accessToken, value: response.data!.token);

        return Success<LoginUserEntity>(data: response.data!.user.toDomain());
      case Error<LoginResponseModel>():
        return Error<LoginUserEntity>(exception: response.exception);
    }
  }
}
