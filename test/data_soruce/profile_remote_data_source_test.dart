import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/featuers/main_profile/api/main_profile_api_client.dart';
import 'package:flowery/featuers/main_profile/data/data_sources/remote_data_source/remote_data_sources_impl.dart';
import 'package:flowery/featuers/main_profile/data/model/profile_response_model.dart';
import 'package:flowery/featuers/main_profile/data/model/user_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_test.mocks.dart';

@GenerateMocks([MainProfileApiClient])
void main() {
  late MockMainProfileApiClient mockApiClient;
  late ProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockMainProfileApiClient();
    dataSource = ProfileRemoteDataSourceImpl(mockApiClient);
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

  group('ProfileRemoteDataSourceImpl', () {
    test(
      'should return Success<User> with user data when API call succeeds',
      () async {
        // arrange
        final tResponse = ProfileResponseModel(message: 'success', user: tUser);
        when(mockApiClient.getProfileData()).thenAnswer((_) async => tResponse);

        // act
        final result = await dataSource.getProfileDate();

        // assert
        expect(result, isA<Success<User>>());
        expect((result as Success<User>).data, equals(tUser));
      },
    );

    test(
      'should return Success<User> with null data when response.user is null',
      () async {
        // arrange
        final tResponse = ProfileResponseModel(message: 'success', user: null);
        when(mockApiClient.getProfileData()).thenAnswer((_) async => tResponse);

        // act
        final result = await dataSource.getProfileDate();

        // assert
        expect(result, isA<Success<User>>());
        expect((result as Success<User>).data, isNull);
      },
    );

    test(
      'should return Error<User> with ServerFailure when API throws DioException with bad response',
      () async {
        // arrange
        final tException = DioException(
          requestOptions: RequestOptions(path: '/auth/profile-data'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/profile-data'),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
        );
        when(mockApiClient.getProfileData()).thenThrow(tException);

        // act
        final result = await dataSource.getProfileDate();

        // assert
        expect(result, isA<Error<User>>());
        final failure = (result as Error<User>).exception as ServerFailure;
        expect(failure.errorMessage, equals('Unauthorized'));
      },
    );

    test(
      'should return Error<User> with ServerFailure when API throws DioException with connection error',
      () async {
        // arrange
        final tException = DioException(
          requestOptions: RequestOptions(path: '/auth/profile-data'),
          type: DioExceptionType.connectionError,
        );
        when(mockApiClient.getProfileData()).thenThrow(tException);

        // act
        final result = await dataSource.getProfileDate();

        // assert
        expect(result, isA<Error<User>>());
        expect((result as Error<User>).exception, isA<ServerFailure>());
      },
    );

    test(
      'should return Error<User> with ServerFailure when API throws unexpected exception',
      () async {
        // arrange
        when(mockApiClient.getProfileData())
            .thenThrow(Exception('Unexpected error'));

        // act
        final result = await dataSource.getProfileDate();

        // assert
        expect(result, isA<Error<User>>());
        expect((result as Error<User>).exception, isA<ServerFailure>());
      },
    );

    test(
      'should call getProfileData() exactly once on the API client',
      () async {
        // arrange
        final tResponse = ProfileResponseModel(message: 'success', user: tUser);
        when(mockApiClient.getProfileData()).thenAnswer((_) async => tResponse);

        // act
        await dataSource.getProfileDate();

        // assert
        verify(mockApiClient.getProfileData()).called(1);
      },
    );
  });
}
