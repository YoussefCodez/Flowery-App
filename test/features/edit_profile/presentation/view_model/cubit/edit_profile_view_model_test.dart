import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/update_logged_user_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/upload_user_photo_use_case.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/states/edit_profile_base_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_view_model_test.mocks.dart';

@GenerateMocks([
  GetLoggedUserUseCase,
  UpdateLoggedUserUseCase,
  UploadUserPhotoUseCase,
])
void main() {
    provideDummy<Result<UserEntity>>(
    Success<UserEntity>(
      data: const UserEntity(
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        gender: '',
        photo: '',
      ),
    ),
  );
  late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;
  late MockUpdateLoggedUserUseCase mockUpdateLoggedUserUseCase;
  late MockUploadUserPhotoUseCase mockUploadUserPhotoUseCase;

  late EditProfileViewModel viewModel;

  late UserEntity user;

  setUp(() {
    mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();
    mockUpdateLoggedUserUseCase = MockUpdateLoggedUserUseCase();
    mockUploadUserPhotoUseCase = MockUploadUserPhotoUseCase();

    viewModel = EditProfileViewModel(
      mockGetLoggedUserUseCase,
      mockUpdateLoggedUserUseCase,
      mockUploadUserPhotoUseCase,
    );

    user = const UserEntity(
      firstName: "Abdelrahman",
      lastName: "Ayoub",
      email: "test@test.com",
      phone: "01012345678",
      gender: "male",
      photo: "photo.png",
    );
  });

  group('GetLoggedUserEvent', () {
    blocTest<EditProfileViewModel, EditProfileBaseState>(
      'emits loading then success',
      build: () {
        when(mockGetLoggedUserUseCase.call()).thenAnswer(
          (_) async => Success<UserEntity>(data: user),
        );

        return viewModel;
      },
      act: (bloc) => bloc.doEvent(GetLoggedUserEvent()),
      expect: () => [
        isA<EditProfileBaseState>()
            .having(
              (s) => s.getProfileState.state,
              'loading',
              StateType.loading,
            ),
        isA<EditProfileBaseState>()
            .having(
              (s) => s.getProfileState.state,
              'success',
              StateType.success,
            )
            .having(
              (s) => s.getProfileState.data,
              'user',
              user,
            ),
      ],
      verify: (_) {
        verify(mockGetLoggedUserUseCase.call()).called(1);
        verifyNoMoreInteractions(mockGetLoggedUserUseCase);
      },
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      'emits loading then error',
      build: () {
        when(mockGetLoggedUserUseCase.call()).thenAnswer(
          (_) async => Error<UserEntity>(
            exception: Exception('error'),
          ),
        );

        return viewModel;
      },
      act: (bloc) => bloc.doEvent(GetLoggedUserEvent()),
      expect: () => [
        isA<EditProfileBaseState>()
            .having(
              (s) => s.getProfileState.state,
              'loading',
              StateType.loading,
            ),
        isA<EditProfileBaseState>()
            .having(
              (s) => s.getProfileState.state,
              'error',
              StateType.error,
            ),
      ],
      verify: (_) {
        verify(mockGetLoggedUserUseCase.call()).called(1);
      },
    );
  });

  group('UpdateLoggedUserEvent', () {
    final editUser = EditUserModel(
      firstName: 'New',
      lastName: 'User',
      email: 'new@test.com',
      phone: '01000000000',
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      'emits loading then success',
      build: () {
        when(
          mockUpdateLoggedUserUseCase.call(editUser),
        ).thenAnswer(
          (_) async => Success<UserEntity>(
            data: user,
          ),
        );

        return viewModel;
      },
      act: (bloc) {
        bloc.doEvent(
          UpdateLoggedUserEvent(editUser),
        );
      },
      expect: () => [
        isA<EditProfileBaseState>()
            .having(
              (s) => s.updateProfileState.state,
              'loading',
              StateType.loading,
            ),
        isA<EditProfileBaseState>()
            .having(
              (s) => s.updateProfileState.state,
              'success',
              StateType.success,
            )
            .having(
              (s) => s.updateProfileState.data,
              'user',
              user,
            ),
      ],
      verify: (_) {
        verify(
          mockUpdateLoggedUserUseCase.call(editUser),
        ).called(1);

        verifyNoMoreInteractions(
          mockUpdateLoggedUserUseCase,
        );
      },
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      'emits loading then error',
      build: () {
        when(
          mockUpdateLoggedUserUseCase.call(editUser),
        ).thenAnswer(
          (_) async => Error<UserEntity>(
            exception: Exception('update failed'),
          ),
        );

        return viewModel;
      },
      act: (bloc) {
        bloc.doEvent(
          UpdateLoggedUserEvent(editUser),
        );
      },
      expect: () => [
        isA<EditProfileBaseState>()
            .having(
              (s) => s.updateProfileState.state,
              'loading',
              StateType.loading,
            ),
        isA<EditProfileBaseState>()
            .having(
              (s) => s.updateProfileState.state,
              'error',
              StateType.error,
            ),
      ],
      verify: (_) {
        verify(
          mockUpdateLoggedUserUseCase.call(editUser),
        ).called(1);
      },
    );
  });

    group("UploadProfilePhotoEvent", () {
    final photo = File("dummy.png");

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "emits loading then success",
      build: () {
        when(
          mockUploadUserPhotoUseCase.call(photo),
        ).thenAnswer(
          (_) async => Success<UserEntity>(
            data: user,
          ),
        );

        return viewModel;
      },
      act: (bloc) =>
          bloc.doEvent(UploadProfilePhotoEvent(photo)),
expect: () => [
  isA<EditProfileBaseState>().having(
    (s) => s.uploadNewPhotoState.state,
    'loading',
    StateType.loading,
  ),
  isA<EditProfileBaseState>()
      .having(
        (s) => s.uploadNewPhotoState.state,
        'success',
        StateType.success,
      )
      .having(
        (s) => s.uploadNewPhotoState.data,
        'user',
        user,
      ),
],
      verify: (_) {
        verify(
          mockUploadUserPhotoUseCase.call(photo),
        ).called(1);

        verifyNoMoreInteractions(
          mockUploadUserPhotoUseCase,
        );
      },
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "emits loading then error",
      build: () {
        when(
          mockUploadUserPhotoUseCase.call(photo),
        ).thenAnswer(
          (_) async => Error<UserEntity>(
            exception: Exception("upload failed"),
          ),
        );

        return viewModel;
      },
      act: (bloc) =>
          bloc.doEvent(UploadProfilePhotoEvent(photo)),
      expect: () => [
        const EditProfileBaseState(
          uploadNewPhotoState: BaseState.loading(),
        ),
        isA<EditProfileBaseState>().having(
          (state) => state.uploadNewPhotoState.state,
          "upload state",
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(
          mockUploadUserPhotoUseCase.call(photo),
        ).called(1);
      },
    );
  });
}