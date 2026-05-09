import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/domain/entities/login_user_entity.dart';
import 'package:flowery/features/login/domain/use_cases/login_use_case.dart';
import 'package:flowery/features/login/presentation/view_model/cubit/login_view_model.dart';
import 'package:flowery/features/login/presentation/view_model/events/login_events.dart';
import 'package:flowery/features/login/presentation/view_model/states/login_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginViewModel viewModel;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    viewModel = LoginViewModel(mockLoginUseCase);
  });


  blocTest<LoginViewModel, LoginStates>(
    "Login View Model when login succeeds",
    // Arrange
    build: () {
      when(() => mockLoginUseCase.call(any(), any())).thenAnswer(
        (_) async => Success<LoginUserEntity>(
          data: LoginUserEntity(
            id: "1",
            firstName: "Ahmed",
            lastName: "Ali",
            email: "ahmed@gmail.com",
            gender: "male",
            phone: "01000000000",
            photo: "photo.png",
          ),
        ),
      );

      return viewModel;
    },

    // Act
    act: (viewModel) {
      viewModel.doEvent(LoginUserEvent(), "ahmed@gmail.com", "123qweASD@");
    },

    // Assert
    expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
  );

  blocTest<LoginViewModel, LoginStates>(
    "Login View Model when login fails",

    // Arrange
    build: () {
      when(() {
        return mockLoginUseCase.call(any(), any());
      }).thenAnswer((_) async {
        return Error<LoginUserEntity>(exception: Exception("Error"));
      });
      return viewModel;
    },

    // Act
    act: (viewModel) {
      viewModel.doEvent(LoginUserEvent(), "ahmed@gmail.com", "123qweASD@");
    },

    // Assert
    expect: () => [isA<LoginLoading>(), isA<LoginError>()],
  );
}
