import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/notifiaction/domain/entity/notifcation_entity.dart';
import 'package:flowery/featuers/notifiaction/domain/use_case/noifaction_use_case.dart';
import 'package:flowery/featuers/notifiaction/presentation/view_model/notifcation_bloc.dart';
import 'package:flowery/featuers/notifiaction/presentation/view_model/notifcation_event.dart';
import 'package:flowery/featuers/notifiaction/presentation/view_model/notifcation_state.dart';

import 'notification_cubit_test.mocks.dart';

@GenerateMocks([GetNotificationsUseCase])
void main() {
  late MockGetNotificationsUseCase mockUseCase;
  late NotificationCubit cubit;

  setUp(() {
    mockUseCase = MockGetNotificationsUseCase();
    cubit = NotificationCubit(mockUseCase);

    provideDummy<Result<List<NotificationEntity>>>(
      const Success(data: []),
    );
  });

  tearDown(() {
    cubit.close();
  });

  const notifications = [
    NotificationEntity(
      title: 'Flowery',
      body: 'Order Delivered',
      isRead: false,
      createdAt: '2026-07-15',
    ),
  ];

  group('NotificationCubit', () {
    blocTest<NotificationCubit, NotificationState>(
      'emits [loading, success] when use case returns notifications',
      build: () {
        when(mockUseCase()).thenAnswer(
              (_) async => const Success<List<NotificationEntity>>(
            data: notifications,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetNotifications()),
      expect: () => [
        const NotificationState(
          notificationsState: BaseState.loading(),
        ),
        const NotificationState(
          notificationsState: BaseState.success(notifications),
        ),
      ],
      verify: (_) {
        verify(mockUseCase()).called(1);
      },
    );

    final exception = Exception('Something went wrong');

    blocTest<NotificationCubit, NotificationState>(
      'emits [loading, error] when use case returns error',
      build: () {
        when(mockUseCase()).thenAnswer(
              (_) async => Error<List<NotificationEntity>>(
            exception: exception,
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetNotifications()),
      expect: () => [
        const NotificationState(
          notificationsState: BaseState.loading(),
        ),
        NotificationState(
          notificationsState: BaseState.error(exception),
        ),
      ],
      verify: (_) {
        verify(mockUseCase()).called(1);
      },
    );
  });
}