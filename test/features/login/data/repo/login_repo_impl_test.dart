import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/data/data_sources/login_data_sources_contract.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';
import 'package:flowery/features/login/data/models/responses/login_user_model.dart';
import 'package:flowery/features/login/data/repo/login_repo_impl.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginDataSources extends Mock implements LoginDataSourcesContract {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late LoginRepoImpl repo;
  late MockLoginDataSources dataSources;
  late MockFlutterSecureStorage fss;
  setUp(() {
    fss = MockFlutterSecureStorage();
    dataSources = MockLoginDataSources();
    repo = LoginRepoImpl(dataSources: dataSources, fss: fss);
  });
  test("Testing login repo when login succeeds", () async {
    // Arrange
    when(() => dataSources.login(any(), any())).thenAnswer(
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

    when(
      () => fss.write(
        key: any(named: "key"),
        value: any(named: "value"),
      ),
    ).thenAnswer((_) async => {});

    // Act
    final response = await repo.login("ahmed@gmail.com", "123qweASD@");

    // Assert
    expect(response, isA<Success<LoginUserEntity>>());
  });

  test("Testing login repo when login fails", () async{

    // Arrange
    when(() => dataSources.login(any(), any())).thenAnswer(
      (_) async => Error<LoginResponseModel>(
        exception: Exception()
      ),
    );

    // Act
    final response = await repo.login("ahmed@gmail.com", "123qweASD@");

    // Assert
    expect(response, isA<Error<LoginUserEntity>>());

  });
}
