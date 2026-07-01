import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/change_password/data/data_sources/change_password_remote_data_sources_contract.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:flowery/features/change_password/data/repo/change_password_repo_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChangePasswordRemoteDataSourcesContract extends Mock
    implements ChangePasswordRemoteDataSourcesContract {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late ChangePasswordRepoImpl repo;
  late MockChangePasswordRemoteDataSourcesContract mockDataSource;
  late MockFlutterSecureStorage fss;
  final ChangePasswordResponseModel successModel = ChangePasswordResponseModel(
    message: "Success",
    token: "token",
  );
  final String oldToken = "oldToken";
  final String errorMessage = "An error has been occured";
  final String oldPassword = "123qweASD@";
  final String newPassword = "456qweASD@";

  setUp(() {
    fss = MockFlutterSecureStorage();
    mockDataSource = MockChangePasswordRemoteDataSourcesContract();
    repo = ChangePasswordRepoImpl(mockDataSource, fss);
  });

  group('Test Change Passowrd Repo', () {
    test('Success Case', () async {
      // Arrange
      when(
        () => fss.read(key: Apikeys.accessToken),
      ).thenAnswer((_) async => oldToken);

      when(() => mockDataSource.changePassword(any(), any())).thenAnswer(
        (_) async => Success<ChangePasswordResponseModel>(data: successModel),
      );

      when(
        () => fss.write(
          key: Apikeys.accessToken,
          value: any(named: "value"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await repo.changePassword(oldPassword, newPassword);
      // Assert
      expect(result, isA<Success<ChangePasswordResponseModel>>());

      verify(() => fss.read(key: Apikeys.accessToken)).called(1);

      verify(
        () => mockDataSource.changePassword(oldPassword, newPassword),
      ).called(1);

      verify(
        () => fss.write(key: Apikeys.accessToken, value: successModel.token),
      ).called(1);
    });

    test('Error Case', () async {
      // Arrange
      when(
        () => fss.read(key: Apikeys.accessToken),
      ).thenAnswer((_) async => oldToken);

      when(() => mockDataSource.changePassword(any(), any())).thenAnswer(
        (_) async => Error<ChangePasswordResponseModel>(
          exception: Exception(errorMessage),
        ),
      );

      when(
        () => fss.write(
          key: Apikeys.accessToken,
          value: any(named: "value"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await repo.changePassword(oldPassword, newPassword);
      
      // Assert
      expect(result, isA<Error<ChangePasswordResponseModel>>());

      verify(() => fss.read(key: Apikeys.accessToken)).called(1);

      verify(
        () => mockDataSource.changePassword(oldPassword, newPassword),
      ).called(1);

      verify(
        () => fss.write(key: Apikeys.accessToken, value: oldToken),
      ).called(1);
    });
  });
}
