import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/main_profile/data/data_sources/remote_data_source/remote_data_sources_contract.dart';
import 'package:flowery/featuers/main_profile/data/model/user_response_model.dart';
import 'package:flowery/featuers/main_profile/data/repo/profile_repo_impl.dart';
import 'package:flowery/featuers/main_profile/domain/entity/profile_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSourceContract])
void main() {
  late MockProfileRemoteDataSourceContract mockDataSource;
  late ProfileRepoImpl repo;

  setUp(() {
    provideDummy<Result<User>>(const Success<User>());
    mockDataSource = MockProfileRemoteDataSourceContract();
    repo = ProfileRepoImpl(mockDataSource);
  });

  final tUser = User(
    id: '123',
    firstName: 'Ahmed',
    lastName: 'Ali',
    email: 'ahmed@test.com',
    gender: 'male',
    phone: '01000000000',
    photo: 'https://photo.png',
    role: 'user',
  );

  group('ProfileRepoImpl', () {
    test(
      'should return Success<ProfileEntity> with mapped entity when data source returns Success<User>',
      () async {
        // arrange
        when(mockDataSource.getProfileDate())
            .thenAnswer((_) async => Success<User>(data: tUser));

        // act
        final result = await repo.getProfileData();

        // assert
        expect(result, isA<Success<ProfileEntity>>());
        final entity = (result as Success<ProfileEntity>).data;
        expect(entity?.id, equals(tUser.id));
        expect(entity?.firstName, equals(tUser.firstName));
        expect(entity?.lastName, equals(tUser.lastName));
        expect(entity?.email, equals(tUser.email));
        expect(entity?.phone, equals(tUser.phone));
        expect(entity?.role, equals(tUser.role));
      },
    );

    test(
      'should use empty string fallback when user fields are null',
      () async {
        // arrange
        final nullFieldsUser = User();
        when(mockDataSource.getProfileDate())
            .thenAnswer((_) async => Success<User>(data: nullFieldsUser));

        // act
        final result = await repo.getProfileData();

        // assert
        expect(result, isA<Success<ProfileEntity>>());
        final entity = (result as Success<ProfileEntity>).data;
        expect(entity?.id, equals(''));
        expect(entity?.firstName, equals(''));
        expect(entity?.email, equals(''));
      },
    );

    test(
      'should return Success<ProfileEntity> with null data when user is null',
      () async {
        // arrange
        when(mockDataSource.getProfileDate())
            .thenAnswer((_) async => const Success<User>(data: null));

        // act
        final result = await repo.getProfileData();

        // assert
        expect(result, isA<Success<ProfileEntity>>());
        expect((result as Success<ProfileEntity>).data, isNull);
      },
    );

    test(
      'should return Error<ProfileEntity> with same exception when data source returns Error',
      () async {
        // arrange
        final tException = Exception('Network error');
        when(mockDataSource.getProfileDate())
            .thenAnswer((_) async => Error<User>(exception: tException));

        // act
        final result = await repo.getProfileData();

        // assert
        expect(result, isA<Error<ProfileEntity>>());
        expect((result as Error<ProfileEntity>).exception, equals(tException));
      },
    );

    test(
      'should call data source getProfileDate exactly once',
      () async {
        // arrange
        when(mockDataSource.getProfileDate())
            .thenAnswer((_) async => Success<User>(data: tUser));

        // act
        await repo.getProfileData();

        // assert
        verify(mockDataSource.getProfileDate()).called(1);
      },
    );
  });
}
