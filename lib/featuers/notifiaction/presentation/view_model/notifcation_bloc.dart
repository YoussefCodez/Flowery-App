import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entity/notifcation_entity.dart';
import '../../domain/use_case/noifaction_use_case.dart';
import 'notifcation_event.dart';
import 'notifcation_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationCubit(this._getNotificationsUseCase)
      : super(const NotificationState());

  void doEvent(NotificationEvent event) {
    switch (event) {
      case GetNotifications():
        _getNotifications();
        break;

      case RefreshNotifications():
        _getNotifications();
        break;
    }
  }

  Future<void> _getNotifications() async {
    emit(
      state.copyWith(
        notificationsState: const BaseState.loading(),
      ),
    );

    final response = await _getNotificationsUseCase();

    switch (response) {
      case Success<List<NotificationEntity>>():
        emit(
          state.copyWith(
            notificationsState: BaseState.success(
              response.data ?? [],
            ),
          ),
        );
        break;

      case Error<List<NotificationEntity>>():
        emit(
          state.copyWith(
            notificationsState: BaseState.error(
              response.exception!,
            ),
          ),
        );
        break;
    }
  }
}