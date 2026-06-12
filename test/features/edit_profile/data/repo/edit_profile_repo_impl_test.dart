import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flowery/features/edit_profile/api/data_sources/edit_profile_remote_data_sources_impl.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';
import 'package:flowery/features/edit_profile/data/models/responses/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditProfileApiClient extends Mock implements EditProfileApiClient {}

void main() {
  late EditProfileRemoteDataSourcesImpl dataSource;
  late MockEditProfileApiClient apiClient;

  final userModel = User(
    firstName: "John",
    lastName: "Doe",
    email: "john@test.com",
    phone: "123",
    gender: "male",
    photo: "img.jpg",
  );

  final responseModel = GetUserResponseModel(
    message: "success",
    user: userModel,
  );

  final editUserModel = EditUserModel(
    firstName: "John",
    lastName: "Doe",
    email: "john@test.com",
    phone: "123",
  );

  final errorMessage = "Error";

  setUp(() {
    apiClient = MockEditProfileApiClient();
    dataSource = EditProfileRemoteDataSourcesImpl(apiClient: apiClient);
  });

  group("Edit Profile Data Source Tests", () {
    test("Get user success", () async {
      when(
        () => apiClient.getCurrentUser(),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.getCurrentLoggedUser();

      expect(result, isA<Success<GetUserResponseModel>>());

      verify(() => apiClient.getCurrentUser()).called(1);
    });

    test("Get user failure", () async {
      when(() => apiClient.getCurrentUser()).thenThrow(
        DioException(requestOptions: RequestOptions(), error: errorMessage),
      );

      final result = await dataSource.getCurrentLoggedUser();

      expect(result, isA<Error<GetUserResponseModel>>());

      verify(() => apiClient.getCurrentUser()).called(1);
    });

    test("Edit profile success", () async {
      when(
        () =>
            apiClient.editCurrentUserProfile(newEdits: any(named: "newEdits")),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.editUserProfile(editUser: editUserModel);

      expect(result, isA<Success<GetUserResponseModel>>());

      verify(() => apiClient.editCurrentUserProfile(newEdits: any(named: "newEdits"))).called(1);
    });

    test("Edit profile failure", () async {
      when(() => apiClient.editCurrentUserProfile(newEdits: any(named: "newEdits"))).thenThrow(
        DioException(requestOptions: RequestOptions(), error: errorMessage),
      );

      final result = await dataSource.editUserProfile(editUser: editUserModel);

      expect(result, isA<Error<GetUserResponseModel>>());

      verify(() => apiClient.editCurrentUserProfile(newEdits: any(named: "newEdits"))).called(1);
    });

    test("Upload photo success", () async {
      when(
        () => apiClient.uploadPhoto(photo: any(named: "photo")),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.uploadUserPhoto(photo: FormData());

      expect(result, isA<Success<GetUserResponseModel>>());

      verify(() => apiClient.uploadPhoto(photo: any(named: "photo"))).called(1);
    });

    test("Upload photo failure", () async {
      when(() => apiClient.uploadPhoto(photo: any(named: "photo"))).thenThrow(
        DioException(requestOptions: RequestOptions(), error: errorMessage),
      );

      final result = await dataSource.uploadUserPhoto(photo: FormData());

      expect(result, isA<Error<GetUserResponseModel>>());

      verify(() => apiClient.uploadPhoto(photo: any(named: "photo"))).called(1);
    });
  });
}
