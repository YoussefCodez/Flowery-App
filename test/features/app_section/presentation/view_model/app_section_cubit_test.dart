import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/features/app_section/presentation/view_model/app_section_cubit.dart';
import 'package:flowery/features/app_section/presentation/view_model/app_section_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSectionCubit', () {
    late AppSectionCubit cubit;

    setUp(() {
      cubit = AppSectionCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state has currentIndex = 0', () {
      expect(cubit.state, const AppSectionState(currentIndex: 0));
    });

    test('isOnHomeTab is true when currentIndex is 0', () {
      expect(cubit.isOnHomeTab, isTrue);
    });

    test('isOnHomeTab is false when currentIndex is not 0', () {
      cubit.changeTab(2);
      expect(cubit.isOnHomeTab, isFalse);
    });

    blocTest<AppSectionCubit, AppSectionState>(
      'changeTab emits new state with updated index',
      build: () => AppSectionCubit(),
      act: (cubit) => cubit.changeTab(1),
      expect: () => [const AppSectionState(currentIndex: 1)],
    );

    blocTest<AppSectionCubit, AppSectionState>(
      'changeTab does NOT emit when same index is selected',
      build: () => AppSectionCubit(),
      act: (cubit) => cubit.changeTab(0),
      expect: () => [],
    );

    blocTest<AppSectionCubit, AppSectionState>(
      'changeTab emits correct index for each tab',
      build: () => AppSectionCubit(),
      act: (cubit) {
        cubit.changeTab(1);
        cubit.changeTab(2);
        cubit.changeTab(3);
      },
      expect: () => [
        const AppSectionState(currentIndex: 1),
        const AppSectionState(currentIndex: 2),
        const AppSectionState(currentIndex: 3),
      ],
    );

    blocTest<AppSectionCubit, AppSectionState>(
      'goToHome emits state with currentIndex = 0',
      build: () => AppSectionCubit(),
      seed: () => const AppSectionState(currentIndex: 3),
      act: (cubit) => cubit.goToHome(),
      expect: () => [const AppSectionState(currentIndex: 0)],
    );

    blocTest<AppSectionCubit, AppSectionState>(
      'goToHome does NOT emit when already on home tab',
      build: () => AppSectionCubit(),
      seed: () => const AppSectionState(currentIndex: 0),
      act: (cubit) => cubit.goToHome(),
      expect: () => [],
    );
  });
}
