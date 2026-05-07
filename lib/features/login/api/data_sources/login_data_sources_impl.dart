import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/login_values.dart';
import 'package:flowery/features/login/api/api_client/login_api_client.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_contract.dart';
import 'package:flowery/features/login/data/models/requests/login_request_model.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginDataSourcesContract)
class LoginDataSourcesImpl implements LoginDataSourcesContract {
  final LoginApiClient apiClient;
  LoginDataSourcesImpl(this.apiClient);

  @override
  Future<Result<LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await apiClient.login(
        LoginRequestModel(email: email, password: password).toJson(),
      );

      return Success<LoginResponseModel>(data: response);
    } catch (e) {
      if (e is DioException) {
        return Error<LoginResponseModel>(
          exception: Exception(e.response?.data[LoginValues.error]),
        );
      }

      return Error<LoginResponseModel>(exception: Exception(e.toString()));
    }
  }
}
