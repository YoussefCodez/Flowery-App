import 'package:dio/dio.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/app_language_logout/api/logout_api_service.dart';
import 'package:flowery/features/app_language_logout/data/data_sources/logout_remote_data_source.dart';
import 'package:flowery/features/app_language_logout/data/models/logout_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_remote_data_source_test.mocks.dart';

@GenerateMocks([LogoutApiService])
void main() {
  late LogoutRemoteDataSourceImpl dataSource;
  late MockLogoutApiService mockLogoutApiService;

  setUp(() {
    mockLogoutApiService = MockLogoutApiService();
    dataSource = LogoutRemoteDataSourceImpl(mockLogoutApiService);
  });

  test("Success logout", () async {
    when(
      mockLogoutApiService.logout(),
    ).thenAnswer((_) async => LogoutResponseModel(message: ''));

    await dataSource.logout();

    verify(mockLogoutApiService.logout()).called(1);
  });
  test("Dio Exception", () async {
    final tDioException = DioException(
      requestOptions: RequestOptions(path: '/home'),
      type: DioExceptionType.connectionError,
    );
    when(
      mockLogoutApiService.logout(),
    ).thenThrow(tDioException);


    await expectLater(
          () async => await dataSource.logout(),
      throwsA(isA<ServerFailure>()),
    );  });
}
