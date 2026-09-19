import 'package:flowery/config/user_helper/user_helper.dart';
import 'package:flowery/features/app_language_logout/data/data_sources/logout_remote_data_source.dart';
import 'package:flowery/features/app_language_logout/data/repositories/logout_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'logout_repository_impl_test.mocks.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LogoutRemoteDataSource,UserHelper])
void main() {

  late MockLogoutRemoteDataSource dataSource;
  late MockUserHelper userHelper;
  late LogoutRepositoryImpl logoutRepository;

  setUp((){
    dataSource = MockLogoutRemoteDataSource();
    userHelper = MockUserHelper();
    logoutRepository = LogoutRepositoryImpl(dataSource, userHelper);
  });


  test('Success', () async {
    // Arrange
    when(dataSource.logout()).thenAnswer((_) async {});
    when(userHelper.clearUserData()).thenAnswer((_) async {});

    // Act
    await logoutRepository.logout();

    // Assert
    verify(dataSource.logout()).called(1);
    verify(userHelper.clearUserData()).called(1);
  });
  test('Error', () async {
    when(dataSource.logout()).thenThrow(Exception('error'));

    await expectLater(
          () async => await logoutRepository.logout(),
      throwsA(isA<Exception>()),
    );
    verifyNever(userHelper.clearUserData());

  });


}