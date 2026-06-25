import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/api/status_code.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/user_helper/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage fss;

  AuthInterceptor({required this.dio, required this.fss});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.cancelToken = getIt<CancelToken>();
    //String? authToken = await fss.read(key: Apikeys.accessToken);
    String? authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmEyM2U1M2RhMWUyOThmNTU2MjU1MzhiIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3ODIzNjEzMjJ9.TZA1LV_f0E-8EfU2x-mbISQ7iYIUW-AeCDE9tK9OWhY";
    if (authToken != null && authToken.isNotEmpty) {
      // options.headers['Authorization'] = 'Bearer $authToken';
     // options.headers[Apikeys.token] = authToken;
      options.headers['Authorization'] = '${Apikeys.bearer} $authToken';

    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("err.response?.statusCode ${err.response?.statusCode}");
    if (err.response?.statusCode == StatusCode.expiredToken) {
      getIt.get<UserHelper>().clearUserData();
    }
    super.onError(err, handler);
  }
}
