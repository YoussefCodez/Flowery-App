import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:flowery/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:flowery/features/change_password/presentation/view_model/cubit/change_password_view_model.dart';
import 'package:flowery/features/change_password/presentation/view_model/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/view_model/states/change_password_base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChangePasswordUseCase extends Mock implements ChangePasswordUseCase {}

void main() {
  late ChangePasswordViewModel viewModel;
  late MockChangePasswordUseCase mockChangePasswordUseCase;
  final String oldPassword = "123qweASD@";
  final String newPassword = "456qweASD@";
  final String errorMessage = "An error has been occured";
  final ChangePasswordResponseModel successPasswordModel =
      ChangePasswordResponseModel(message: "Success", token: "token");
  final ChangePasswordResponseModel errorPasswordModel =
      ChangePasswordResponseModel(message: errorMessage);
  setUp(() {
    mockChangePasswordUseCase = MockChangePasswordUseCase();
    viewModel = ChangePasswordViewModel(mockChangePasswordUseCase);
  });
  group("Testing Change Password ViewModel", () {
    blocTest<ChangePasswordViewModel, ChangePasswordBaseState>(
      "Success Case",

      // Arrange
      setUp: () {
        when(() => mockChangePasswordUseCase.call(any(), any())).thenAnswer(
          (_) async =>
              Success<ChangePasswordResponseModel>(data: successPasswordModel),
        );
      },
      build: () => viewModel,

      // Act
      act: (_) => viewModel.doEvent(
        ChangePasswordEvent(),
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),

      // Assert
      expect: () => [
        ChangePasswordBaseState(isChangingPassword: true),
        ChangePasswordBaseState(
          isChangingPassword: false,
          didChangePasswordfail: false,
        ),
      ],

      verify: (_) {
        verify(() => mockChangePasswordUseCase.call(any(), any())).called(1);
      },
    );

    blocTest<ChangePasswordViewModel, ChangePasswordBaseState>(
      "Error Case",

      // Arrange
      setUp: () {
        when(() => mockChangePasswordUseCase.call(any(), any())).thenAnswer(
          (_) async => Error<ChangePasswordResponseModel>(
            exception: Exception(errorPasswordModel.message),
          ),
        );
      },
      build: () => viewModel,

      // Act
      act: (_) => viewModel.doEvent(
        ChangePasswordEvent(),
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),

      // Assert
      expect: () => [
        ChangePasswordBaseState(isChangingPassword: true),
        ChangePasswordBaseState(
          isChangingPassword: false,
          didChangePasswordfail: true,
        ),
      ],

      verify: (_) {
        verify(() => mockChangePasswordUseCase.call(any(), any())).called(1);
      },
    );
  });
}
