import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';

class ApiExecutor {
  static Future<Result<T>> execute<T>(
      Future<T> Function() request,
      ) async {
    try {
      final response = await request();

      return Success<T>(data: response);
    } on DioException catch (e) {
      final serverMessage =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      return Error<T>(
        exception: Exception(serverMessage),
      );
    } on TimeoutException catch (e) {
      return Error<T>(
        exception: Exception(
          e.message ?? 'Timeout Exception',
        ),
      );
    } catch (e) {
      return Error<T>(
        exception: Exception(e.toString()),
      );
    }
  }
}