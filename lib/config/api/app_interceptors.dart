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
    await fss.write(key: Apikeys.accessToken, value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjlmZjViNTU2YmJhZjE1ODhiYmRlMmI2Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3ODM2MjM4MzJ9.5w-SXKCIEyCKFVYLxzyxU7Ko5ms1_c7VyK5RSHj9tPo");
    String? authToken = await fss.read(key: Apikeys.accessToken);
    print("This is the auth Token : $authToken");
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
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
