import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/features/edit_profile/api/data_sources/edit_profile_remote_data_sources_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockEditProfileApiClient extends Mock implements EditProfileApiClient {}

@GenerateMocks([EditProfileApiClient])
void main() {
  late MockEditProfileApiClient mockApiClient;
  late EditProfileRemoteDataSourcesImpl dataSource;

  late GetUserResponseModel responseModel;

  setUp(() {
    mockApiClient = MockEditProfileApiClient();

    dataSource = EditProfileRemoteDataSourcesImpl(apiClient: mockApiClient);

    responseModel = GetUserResponseModel(
      message: "Success",
      user: User(
        firstName: "Abdelrahman",
        lastName: "Ayoub",
        email: "test@test.com",
        phone: "01012345678",
        gender: "male",
        photo: "photo.png",
      ),
    );
  });

  group('getCurrentLoggedUser', () {
    test('should return Success when api succeeds', () async {
      when(
        mockApiClient.getCurrentUser(),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.getCurrentLoggedUser();

      expect(result, isA<Success<GetUserResponseModel>>());

      final success = result as Success<GetUserResponseModel>;

      expect(success.data, responseModel);

      verify(mockApiClient.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return Error when api throws DioException', () async {
      when(
        mockApiClient.getCurrentUser(),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await dataSource.getCurrentLoggedUser();

      expect(result, isA<Error<GetUserResponseModel>>());

      verify(mockApiClient.getCurrentUser()).called(1);
    });
  });

  group('editUserProfile', () {
    final editUser = EditUserModel(
      firstName: 'New',
      lastName: 'Name',
      email: 'new@test.com',
      phone: '01000000000',
    );

    test('should return Success when api succeeds', () async {
      when(
        mockApiClient.editCurrentUserProfile(newEdits: editUser),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.editUserProfile(editUser);

      expect(result, isA<Success<GetUserResponseModel>>());

      final success = result as Success<GetUserResponseModel>;

      expect(success.data, responseModel);

      verify(
        mockApiClient.editCurrentUserProfile(newEdits: editUser),
      ).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return Error when api throws DioException', () async {
      when(
        mockApiClient.editCurrentUserProfile(newEdits: editUser),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await dataSource.editUserProfile(editUser);

      expect(result, isA<Error<GetUserResponseModel>>());

      verify(
        mockApiClient.editCurrentUserProfile(newEdits: editUser),
      ).called(1);
    });
  });

  group('uploadUserPhoto', () {
    final photo = File('dummy.png');

    test('should return Success when upload succeeds', () async {
      when(
        mockApiClient.uploadPhoto(photo),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.uploadUserPhoto(photo);

      expect(result, isA<Success<GetUserResponseModel>>());

      final success = result as Success<GetUserResponseModel>;

      expect(success.data, responseModel);

      verify(mockApiClient.uploadPhoto(photo)).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return Error when upload throws DioException', () async {
      when(
        mockApiClient.uploadPhoto(photo),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await dataSource.uploadUserPhoto(photo);

      expect(result, isA<Error<GetUserResponseModel>>());

      verify(mockApiClient.uploadPhoto(photo)).called(1);
    });
  });
}
