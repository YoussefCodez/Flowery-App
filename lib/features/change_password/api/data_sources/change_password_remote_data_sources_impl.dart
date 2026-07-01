import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/change_password_values.dart';
import 'package:flowery/features/change_password/api/api_client/change_password_api_client.dart';
import 'package:flowery/features/change_password/data/data_sources/change_password_remote_data_sources_contract.dart';
import 'package:flowery/features/change_password/data/models/requests/change_password_request_model.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRemoteDataSourcesContract)
class ChangePasswordRemoteDataSourcesImpl
    implements ChangePasswordRemoteDataSourcesContract {
  final ChangePasswordApiClient apiClient;
  ChangePasswordRemoteDataSourcesImpl(this.apiClient);

  @override
  Future<Result<ChangePasswordResponseModel>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await apiClient.changePassword(
        passwords: ChangePasswordRequestModel(
          password: oldPassword,
          newPassword: newPassword,
        ).toJson(),
      );
      return Success<ChangePasswordResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<ChangePasswordResponseModel>(
        exception: Exception(e.response?.data[ChangePasswordValues.error]),
      );
    }
  }
}
