import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/featuers/main_profile/api/main_profile_api_client.dart';
import 'package:flowery/featuers/main_profile/data/data_sources/remote_data_source/remote_data_sources_contract.dart';
import 'package:flowery/featuers/main_profile/data/model/user_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final MainProfileApiClient mainProfileApiClient;

  ProfileRemoteDataSourceImpl(this.mainProfileApiClient);

  @override
  Future<Result<User>> getProfileDate() async {
    try {
      final response = await mainProfileApiClient.getProfileData();
      return Success<User>(data: response.user);
    } on DioException catch (e) {
      return Error<User>(exception: _mapDioException(e));
    } catch (e) {
      return Error<User>(
        exception: ServerFailure(errorMessage: e.toString()),
      );
    }
  }

  ServerFailure _mapDioException(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      final data = e.response?.data;
      final message = data is Map
          ? (data['error'] ?? data['message'] ?? 'An error occurred')
          : 'An error occurred';
      return ServerFailure(errorMessage: message.toString());
    }
    return ServerFailure(errorMessage: e.message ?? 'An error occurred');
  }
}