import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/update_logged_user_use_case.dart';
import 'package:flowery/features/edit_profile/domain/use_cases/upload_user_photo_use_case.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/states/edit_profile_base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLoggedUserUseCase extends Mock implements GetLoggedUserUseCase {}

class MockUpdateLoggedUserUseCase extends Mock
    implements UpdateLoggedUserUseCase {}

class MockUploadUserPhotoUseCase extends Mock
    implements UploadUserPhotoUseCase {}

void main() {
  late EditProfileViewModel viewModel;

  late MockGetLoggedUserUseCase mockGetLoggedUser;
  late MockUpdateLoggedUserUseCase mockUpdateUser;
  late MockUploadUserPhotoUseCase mockUploadPhoto;

  final user = UserEntity(
    firstName: "John",
    lastName: "Doe",
    email: "john@test.com",
    phone: "123",
    gender: "male",
    photo: "image.jpg",
  );

  final errorMessage = "Error occurred";

  setUpAll(() {
    mockGetLoggedUser = MockGetLoggedUserUseCase();
    mockUpdateUser = MockUpdateLoggedUserUseCase();
    mockUploadPhoto = MockUploadUserPhotoUseCase();
  });

  group("Edit Profile ViewModel Tests", () {
    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "Get logged user success",
      setUp: () {
        when(
          () => mockGetLoggedUser.call(),
        ).thenAnswer((_) async => Success<UserEntity>(data: user));
      },
      build: () {
        viewModel = EditProfileViewModel(
          mockGetLoggedUser,
          mockUpdateUser,
          mockUploadPhoto,
        );
        return viewModel;
      },
      act: (vm) => vm.doEvent(GetLoggedUserEvent()),
      expect: () => [
        const EditProfileBaseState(isLoadingProfile: true),
        EditProfileBaseState(isLoadingProfile: false, user: user),
      ],
      verify: (_) {
        verify(() => mockGetLoggedUser.call()).called(1);
      },
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "Get logged user failure",
      setUp: () {
        when(() => mockGetLoggedUser.call()).thenAnswer(
          (_) async => Error<UserEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () {
        viewModel = EditProfileViewModel(
          mockGetLoggedUser,
          mockUpdateUser,
          mockUploadPhoto,
        );
        return viewModel;
      },
      act: (vm) => vm.doEvent(GetLoggedUserEvent()),
      expect: () => [
        const EditProfileBaseState(isLoadingProfile: true),
        EditProfileBaseState(
          isLoadingProfile: false,
          errorMessage: Exception(errorMessage).toString(),
        ),
      ],
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "Update user success",
      setUp: () {
        when(
          () => mockUpdateUser.call(any()),
        ).thenAnswer((_) async => Success<UserEntity>(data: user));
      },
      build: () {
        viewModel = EditProfileViewModel(
          mockGetLoggedUser,
          mockUpdateUser,
          mockUploadPhoto,
        );
        return viewModel;
      },
      act: (vm) => vm.doEvent(
        UpdateLoggedUserEvent(),
        user: EditUserModel(
          firstName: "John",
          lastName: "Doe",
          email: "john@test.com",
          phone: "123",
        ),
      ),
      expect: () => [
        const EditProfileBaseState(isLoadingProfile: true),
        EditProfileBaseState(isLoadingProfile: false, user: user),
      ],
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "Update user failure",
      setUp: () {
        when(() => mockUpdateUser.call(any())).thenAnswer(
          (_) async => Error<UserEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () {
        viewModel = EditProfileViewModel(
          mockGetLoggedUser,
          mockUpdateUser,
          mockUploadPhoto,
        );
        return viewModel;
      },
      act: (vm) => vm.doEvent(
        UpdateLoggedUserEvent(),
        user: EditUserModel(
          firstName: "John",
          lastName: "Doe",
          email: "john@test.com",
          phone: "123",
        ),
      ),
      expect: () => [
        const EditProfileBaseState(isLoadingProfile: true),
        EditProfileBaseState(
          isLoadingProfile: false,
          errorMessage: Exception(errorMessage).toString(),
        ),
      ],
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "Upload photo success",
      setUp: () {
        when(
          () => mockUploadPhoto.call(any()),
        ).thenAnswer((_) async => Success<UserEntity>(data: user));

        when(
          () => mockGetLoggedUser.call(),
        ).thenAnswer((_) async => Success<UserEntity>(data: user));
      },
      build: () {
        viewModel = EditProfileViewModel(
          mockGetLoggedUser,
          mockUpdateUser,
          mockUploadPhoto,
        );
        return viewModel;
      },
      act: (vm) => vm.doEvent(UploadProfilePhotoEvent(), photo: FormData()),
      expect: () => [
        const EditProfileBaseState(isLoadingProfile: true),
        EditProfileBaseState(isLoadingProfile: false, user: user),
      ],
    );

    blocTest<EditProfileViewModel, EditProfileBaseState>(
      "Upload photo failure",
      setUp: () {
        when(() => mockUploadPhoto.call(any())).thenAnswer(
          (_) async => Error<UserEntity>(exception: Exception(errorMessage)),
        );
      },
      build: () {
        viewModel = EditProfileViewModel(
          mockGetLoggedUser,
          mockUpdateUser,
          mockUploadPhoto,
        );
        return viewModel;
      },
      act: (vm) => vm.doEvent(UploadProfilePhotoEvent(), photo: FormData()),
      expect: () => [
        const EditProfileBaseState(isLoadingProfile: true),
        EditProfileBaseState(
          isLoadingProfile: false,
          errorMessage: Exception(errorMessage).toString(),
        ),
      ],
    );
  });
}
