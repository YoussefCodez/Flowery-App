import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/register/data/models/responce/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowery/features/register/presentation/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/cubit/register_states.dart';
import 'package:flowery/features/register/presentation/cubit/register_events.dart';
import 'package:flowery/features/register/domain/use_case/register_use_case.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart'; // ← add this
import 'package:flowery/config/base_state/base_state.dart';

import 'package:flowery/config/base_response/base_response.dart' as base; // ← add alias
/// Mock UseCase
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

void main() {
  late MockRegisterUseCase useCase;
  late RegisterCubit cubit;

  setUp(() {
    useCase = MockRegisterUseCase();
    cubit = RegisterCubit(useCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('RegisterCubit - simple events', () {
    blocTest<RegisterCubit, RegisterStates>(
      'emits updated gender when GenderChanged is added',
      build: () => cubit,
    
      act: (c) => c.doIntent(GenderChanged('male')),
      expect: () => [
        isA<RegisterStates>().having((s) => s.gender, 'gender', 'male'),
      ],
    );

    blocTest<RegisterCubit, RegisterStates>(
      'toggles terms accepted',
      build: () => cubit,
      act: (c) => c.doIntent(ToggleTermsAccepted()),
      expect: () => [
        isA<RegisterStates>().having((s) => s.isTermsAccepted, 'terms', true),
      ],
    );

    blocTest<RegisterCubit, RegisterStates>(
      'toggles password visibility',
      build: () => cubit,
      act: (c) => c.doIntent(TogglePasswordVisibility()),
      expect: () => [
        isA<RegisterStates>().having(
          (s) => s.isPasswordVisible,
          'passwordVisible',
          true,
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterStates>(
      'toggles confirm password visibility',
      build: () => cubit,
      act: (c) => c.doIntent(ToggleConfirmPasswordVisibility()),
      expect: () => [
        isA<RegisterStates>().having(
          (s) => s.isConfirmPasswordVisible,
          'confirmPasswordVisible',
          true,
        ),
      ],
    );
  });

  group('RegisterCubit - sign up', () {
    final event = SignUpButtonPressed(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@test.com',
      password: '123456',
      confirmPassword: '123456',
      phoneNumber: '01000000000',
      gender: 'male',
    );

    blocTest<RegisterCubit, RegisterStates>(
      'does NOT call use case when terms not accepted',
      build: () => cubit,
      act: (c) => c.doIntent(event),
      verify: (_) {
        verifyNever(() => useCase.call(any()));
      },
    );

    blocTest<RegisterCubit, RegisterStates>(
      'emits loading then success when register succeeds',
      build: () {
      
        when(() => useCase.call(any())).thenAnswer(
          (_) async => Success<RegisterEntity>(
            data: RegisterEntity(
              message: 'success',
              user: User(/* required fields */),
              token: 'mock_token',
            ),
          ),
        );
        return cubit;
      },
      seed: () => const RegisterStates(isTermsAccepted: true),
      act: (c) => c.doIntent(event),
      expect: () => [
        isA<RegisterStates>().having(
          (s) => s.registerRequestState,
          'loading',
          const BaseState<void>.loading(),
        ),
        isA<RegisterStates>().having(
          (s) => s.registerRequestState,
          'success',
          const BaseState<void>.success(null),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterStates>(
      'emits loading then error when register fails',
      build: () {
        when(() => useCase.call(any())).thenAnswer(
        
          (_) async => base.Error<RegisterEntity>(exception: Exception('fail')),
        );
        return cubit;
      },
      seed: () => const RegisterStates(isTermsAccepted: true),
      act: (c) => c.doIntent(event),
      expect: () => [
        isA<RegisterStates>().having(
          (s) => s.registerRequestState,
          'loading',
          const BaseState<void>.loading(),
        ),
        isA<RegisterStates>().having(
          (s) => s.registerRequestState,
          'error',
          isA<Exception>(),
        ),
      ],
    );
  });
}
