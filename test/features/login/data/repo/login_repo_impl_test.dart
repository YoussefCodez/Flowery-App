import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_local_contract.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_remote_contract.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';
import 'package:flowery/features/login/data/models/responses/login_user_model.dart';
import 'package:flowery/features/login/data/repo/login_repo_impl.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRemoteDataSources extends Mock
    implements LoginDataSourcesRemoteContract {}

class MockLoginLocalDataSources extends Mock
    implements LoginDataSourcesLocalContract {}

void main() {
  late LoginRepoImpl repo;
  late MockLoginRemoteDataSources remoteDataSources;
  late MockLoginLocalDataSources localDataSources;

  setUp(() {
    remoteDataSources = MockLoginRemoteDataSources();
    localDataSources = MockLoginLocalDataSources();
    repo = LoginRepoImpl(
      remoteDataSource: remoteDataSources,
      localDataSource: localDataSources,
    );
  });
  test("Testing login repo when login succeeds", () async {
    // Arrange
    when(() => remoteDataSources.login(any(), any())).thenAnswer(
      (_) async => Success<LoginResponseModel>(
        data: LoginResponseModel(
          message: "success",
          token: "token",
          user: LoginUserModel(
            id: "1",
            firstName: "Ahmed",
            lastName: "Ali",
            email: "ahmed@gmail.com",
            gender: "male",
            phone: "01000000000",
            photo: "photo.png",
            role: 'admin',
            wishlist: [],
            addresses: [],
            createdAt: DateTime.now(),
          ),
        ),
      ),
    );

    when(() => localDataSources.saveToken("Token")).thenAnswer((_) async => {});

    // Act
    final response = await repo.login("ahmed@gmail.com", "123qweASD@");

    // Assert
    expect(response, isA<Success<LoginUserEntity>>());
  });

  test("Testing login repo when login fails", () async {
    // Arrange
    when(() => remoteDataSources.login(any(), any())).thenAnswer(
      (_) async => Error<LoginResponseModel>(exception: Exception()),
    );

    // Act
    final response = await repo.login("ahmed@gmail.com", "123qweASD@");

    // Assert
    expect(response, isA<Error<LoginUserEntity>>());
  });
}
