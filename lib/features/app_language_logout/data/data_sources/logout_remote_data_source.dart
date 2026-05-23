import 'package:dio/dio.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/app_language_logout/api/logout_api_service.dart';
import 'package:injectable/injectable.dart';

abstract class LogoutRemoteDataSource {
  Future<void> logout();
}

@Injectable(as: LogoutRemoteDataSource)
class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSource {
  final LogoutApiService _apiService;

  LogoutRemoteDataSourceImpl(this._apiService);

  @override
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map
          ? (data['error'] ?? data['message'] ?? 'An error occurred')
          : 'An error occurred';
      throw ServerFailure(errorMessage: message.toString());
    }
  }
}
