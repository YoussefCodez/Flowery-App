import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/change_password/data/data_sources/change_password_remote_data_sources_contract.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:flowery/features/change_password/domain/repo/change_password_repo_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepoContract)
class ChangePasswordRepoImpl implements ChangePasswordRepoContract {
  final ChangePasswordRemoteDataSourcesContract dataSource;
  final FlutterSecureStorage fss;
  ChangePasswordRepoImpl(this.dataSource, this.fss);

  @override
  Future<Result<ChangePasswordResponseModel>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final oldToken = await fss.read(key: Apikeys.accessToken);
    final response = await dataSource.changePassword(oldPassword, newPassword);
    switch (response) {
      case Success<ChangePasswordResponseModel>():
        await fss.write(key: Apikeys.accessToken, value: response.data?.token);
        return Success<ChangePasswordResponseModel>(data: response.data);
      case Error<ChangePasswordResponseModel>():
        await fss.write(key: Apikeys.accessToken, value: oldToken);
        return Error<ChangePasswordResponseModel>(
          exception: response.exception,
        );
    }
  }
}
