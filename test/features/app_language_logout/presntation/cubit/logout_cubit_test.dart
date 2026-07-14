import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/app_language_logout/domain/use_cases/logout_use_case.dart';
import 'package:flowery/features/app_language_logout/presntation/cubit/logout_cubit.dart';
import 'package:flowery/features/app_language_logout/presntation/cubit/logout_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  late LogoutCubit cubit;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    cubit = LogoutCubit(mockLogoutUseCase);
  });

  tearDown(() => cubit.close());


  blocTest<LogoutCubit, BaseState<void>>(
    'emit loading then success when logout succeeds',
    build: () {
      when(mockLogoutUseCase()).thenAnswer((_) async {});
      return cubit;
    },
    act: (bloc) => bloc.doAction(LogoutEvent.logout),
    expect: () => [
      const BaseState<void>.loading(),
      const BaseState<void>.success(null),
    ],
  );


  blocTest<LogoutCubit, BaseState<void>>(
    'emit loading then error when logout fails',
    build: () {
      when(mockLogoutUseCase()).thenThrow(Exception('error'));
      return cubit;
    },
    act: (bloc) => bloc.doAction(LogoutEvent.logout),
    expect: () => [
      const BaseState<void>.loading(),
      predicate<BaseState<void>>(
            (s) => s.state == StateType.error,
      ),
    ],
  );
}