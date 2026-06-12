import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/change_password_values.dart';
import 'package:flowery/features/change_password/api/api_client/change_password_api_client.dart';
import 'package:flowery/features/change_password/api/data_sources/change_password_remote_data_sources_impl.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChangePasswordApiClient extends Mock implements ChangePasswordApiClient{}

void main() {
  late ChangePasswordRemoteDataSourcesImpl dataSource;
  late MockChangePasswordApiClient mockApiClient;

  final successModel = ChangePasswordResponseModel(
    message: 'Success',
    token: 'token',
  );

  const oldPassword = '123qweASD@';
  const newPassword = '456qweASD@';

  setUp(() {
    mockApiClient = MockChangePasswordApiClient();
    dataSource = ChangePasswordRemoteDataSourcesImpl(mockApiClient);
  });

  group('ChangePasswordRemoteDataSource', () {
    test('Success Case', () async {
      // Arrange
      when(
        () => mockApiClient.changePassword(passwords: any(named: 'passwords')),
      ).thenAnswer((_) async => successModel);

      // Act
      final result = await dataSource.changePassword(oldPassword, newPassword);

      // Assert
      expect(result, isA<Success<ChangePasswordResponseModel>>());

      verify(
        () => mockApiClient.changePassword(passwords: any(named: 'passwords')),
      ).called(1);
    });

    test('Error Case', () async {
      // Arrange
      const errorMessage = 'Wrong password';

      when(
        () => mockApiClient.changePassword(passwords: any(named: 'passwords')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {ChangePasswordValues.error: errorMessage},
          ),
        ),
      );

      // Act
      final result = await dataSource.changePassword(oldPassword, newPassword);

      // Assert
      expect(result, isA<Error<ChangePasswordResponseModel>>());

      final errorResult = result as Error<ChangePasswordResponseModel>;

      expect(errorResult.exception.toString(), contains(errorMessage));

      verify(
        () => mockApiClient.changePassword(passwords: any(named: 'passwords')),
      ).called(1);
    });
  });
}
