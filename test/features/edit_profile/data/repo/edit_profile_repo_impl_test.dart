import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/data_sources/edit_profile_remote_data_sources_contract.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/user_model.dart';
import 'package:flowery/features/edit_profile/data/repo/edit_profile_repo_impl.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repo_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSourcesContract])
void main() {
  provideDummy<Result<GetUserResponseModel>>(
    Success<GetUserResponseModel>(
      data: GetUserResponseModel(),
    ),
  );
  late MockEditProfileRemoteDataSourcesContract mockRemoteDataSource;
  late EditProfileRepoImpl repo;

  late GetUserResponseModel responseModel;
  late UserEntity userEntity;

  setUp(() {
    mockRemoteDataSource = MockEditProfileRemoteDataSourcesContract();

    repo = EditProfileRepoImpl(
      remoteDataSource: mockRemoteDataSource,
    );

    responseModel = GetUserResponseModel(
      message: "success",
      user: User(
        firstName: "Abdelrahman",
        lastName: "Ayoub",
        email: "test@test.com",
        phone: "01012345678",
        gender: "male",
        photo: "photo.png",
      ),
    );

    userEntity = responseModel.user!.toDomain();
  });

  group("getLoggedUserInfo", () {
    test("should return Success<UserEntity>", () async {
      when(
        mockRemoteDataSource.getCurrentLoggedUser(),
      ).thenAnswer(
        (_) async => Success<GetUserResponseModel>(
          data: responseModel,
        ),
      );

      final result = await repo.getLoggedUserInfo();

      expect(result, isA<Success<UserEntity>>());

      final success = result as Success<UserEntity>;

      expect(success.data, userEntity);

      verify(
        mockRemoteDataSource.getCurrentLoggedUser(),
      ).called(1);

      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test("should return Error<UserEntity>", () async {
      final exception = Exception("error");

      when(
        mockRemoteDataSource.getCurrentLoggedUser(),
      ).thenAnswer(
        (_) async => Error<GetUserResponseModel>(
          exception: exception,
        ),
      );

      final result = await repo.getLoggedUserInfo();

      expect(result, isA<Error<UserEntity>>());

      final error = result as Error<UserEntity>;

      expect(error.exception, exception);

      verify(
        mockRemoteDataSource.getCurrentLoggedUser(),
      ).called(1);
    });
  });

  group("editUserProfile", () {
    final editUser = EditUserModel(
      firstName: "New",
      lastName: "User",
      email: "new@test.com",
      phone: "01000000000",
    );

    test("should return Success<UserEntity>", () async {
      when(
        mockRemoteDataSource.editUserProfile(editUser),
      ).thenAnswer(
        (_) async => Success<GetUserResponseModel>(
          data: responseModel,
        ),
      );

      final result = await repo.editUserProfile(editUser);

      expect(result, isA<Success<UserEntity>>());

      final success = result as Success<UserEntity>;

      expect(success.data, userEntity);

      verify(
        mockRemoteDataSource.editUserProfile(editUser),
      ).called(1);

      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test("should return Error<UserEntity>", () async {
      final exception = Exception();

      when(
        mockRemoteDataSource.editUserProfile(editUser),
      ).thenAnswer(
        (_) async => Error<GetUserResponseModel>(
          exception: exception,
        ),
      );

      final result = await repo.editUserProfile(editUser);

      expect(result, isA<Error<UserEntity>>());

      final error = result as Error<UserEntity>;

      expect(error.exception, exception);

      verify(
        mockRemoteDataSource.editUserProfile(editUser),
      ).called(1);
    });
  });

  group("uploadProfilePhoto", () {
    final photo = File("dummy.png");

    test(
      "should upload photo then fetch user and return Success<UserEntity>",
      () async {
        when(
          mockRemoteDataSource.uploadUserPhoto(photo),
        ).thenAnswer(
          (_) async => Success<GetUserResponseModel>(
            data: responseModel,
          ),
        );

        when(
          mockRemoteDataSource.getCurrentLoggedUser(),
        ).thenAnswer(
          (_) async => Success<GetUserResponseModel>(
            data: responseModel,
          ),
        );

        final result = await repo.uploadProfilePhoto(photo);

        expect(result, isA<Success<UserEntity>>());

        final success = result as Success<UserEntity>;

        expect(success.data, userEntity);

        verify(
          mockRemoteDataSource.uploadUserPhoto(photo),
        ).called(1);

        verify(
          mockRemoteDataSource.getCurrentLoggedUser(),
        ).called(1);

        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      "should return upload error if upload fails",
      () async {
        final exception = Exception("upload failed");

        when(
          mockRemoteDataSource.uploadUserPhoto(photo),
        ).thenAnswer(
          (_) async => Error<GetUserResponseModel>(
            exception: exception,
          ),
        );

        final result = await repo.uploadProfilePhoto(photo);

        expect(result, isA<Error<UserEntity>>());

        final error = result as Error<UserEntity>;

        expect(error.exception, exception);

        verify(
          mockRemoteDataSource.uploadUserPhoto(photo),
        ).called(1);

        verifyNever(
          mockRemoteDataSource.getCurrentLoggedUser(),
        );
      },
    );

    test(
      "should return error when fetching user fails after successful upload",
      () async {
        final exception = Exception("fetch failed");

        when(
          mockRemoteDataSource.uploadUserPhoto(photo),
        ).thenAnswer(
          (_) async => Success<GetUserResponseModel>(
            data: responseModel,
          ),
        );

        when(
          mockRemoteDataSource.getCurrentLoggedUser(),
        ).thenAnswer(
          (_) async => Error<GetUserResponseModel>(
            exception: exception,
          ),
        );

        final result = await repo.uploadProfilePhoto(photo);

        expect(result, isA<Error<UserEntity>>());

        final error = result as Error<UserEntity>;

        expect(error.exception, exception);

        verify(
          mockRemoteDataSource.uploadUserPhoto(photo),
        ).called(1);

        verify(
          mockRemoteDataSource.getCurrentLoggedUser(),
        ).called(1);

        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}