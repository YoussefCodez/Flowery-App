import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/featuers/main_profile/domain/use_case/profile_use_case.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_event.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase])
void main() {
  late MockGetProfileDataUseCase mockUseCase;

  setUp(() {
    provideDummy<Result<ProfileEntity>>(const Success<ProfileEntity>());
    mockUseCase = MockGetProfileDataUseCase();
  });

  final tEntity = ProfileEntity(
    id: '123',
    firstName: 'Ahmed',
    lastName: 'Ali',
    email: 'ahmed@test.com',
    gender: 'male',
    phone: '01000000000',
    photo: 'https://photo.png',
    role: 'user',
  );

  group('ProfileCubit', () {
    test('initial state should have BaseState.initial()', () {
      final cubit = ProfileCubit(mockUseCase);

      expect(
        cubit.state.getProfileDate,
        const BaseState<ProfileEntity>.initial(),
      );

      cubit.close();
    });

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when GetProfileDate event succeeds',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => Success<ProfileEntity>(data: tEntity),
        );
        return ProfileCubit(mockUseCase);
      },
      act: (cubit) => cubit.doEvent(GetProfileDate()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.getProfileDate.state,
          'loading',
          StateType.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.getProfileDate.state,
          'success',
          StateType.success,
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'success state should contain the returned ProfileEntity',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => Success<ProfileEntity>(data: tEntity),
        );
        return ProfileCubit(mockUseCase);
      },
      act: (cubit) => cubit.doEvent(GetProfileDate()),
      expect: () => [
        isA<ProfileState>(),
        isA<ProfileState>().having(
          (s) => s.getProfileDate.data,
          'entity data',
          tEntity,
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] when GetProfileDate event fails',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async =>
              Error<ProfileEntity>(exception: Exception('Server error')),
        );
        return ProfileCubit(mockUseCase);
      },
      act: (cubit) => cubit.doEvent(GetProfileDate()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.getProfileDate.state,
          'loading',
          StateType.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.getProfileDate.state,
          'error',
          StateType.error,
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'error state should contain the exception',
      build: () {
        final tException = Exception('Server error');
        when(mockUseCase.call()).thenAnswer(
          (_) async => Error<ProfileEntity>(exception: tException),
        );
        return ProfileCubit(mockUseCase);
      },
      act: (cubit) => cubit.doEvent(GetProfileDate()),
      expect: () => [
        isA<ProfileState>(),
        isA<ProfileState>().having(
          (s) => s.getProfileDate.exception,
          'exception',
          isA<Exception>(),
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'should call GetProfileDataUseCase exactly once',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => Success<ProfileEntity>(data: tEntity),
        );
        return ProfileCubit(mockUseCase);
      },
      act: (cubit) => cubit.doEvent(GetProfileDate()),
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );
  });
}
