import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_local_contract.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_remote_contract.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:flowery/features/login/domain/repo/login_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  final LoginDataSourcesLocalContract localDataSource;
  final LoginDataSourcesRemoteContract remoteDataSource;
  LoginRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<LoginUserEntity>> login(String email, String password) async {
    final response = await remoteDataSource.login(email, password);

    switch (response) {
      case Success<LoginResponseModel>():

        // Saving the new token
        await localDataSource.saveToken(response.data?.token);

        return Success<LoginUserEntity>(data: response.data!.user?.toDomain());
      case Error<LoginResponseModel>():
        return Error<LoginUserEntity>(exception: response.exception);
    }
  }
}
