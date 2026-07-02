import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/main_profile/domain/use_case/get_notification_state_use_case.dart';
import 'package:flowery/features/main_profile/domain/use_case/profile_use_case.dart';
import 'package:flowery/features/main_profile/domain/use_case/toggle_notification_use_case.dart';
import 'package:flowery/features/main_profile/presentation/view_model/profile_event.dart';
import 'package:flowery/features/main_profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final GetNotificationStateUseCase _getNotificationStateUseCase;
  final ToggleNotificationUseCase _toggleNotificationUseCase;
  ProfileCubit(
    this._getProfileDataUseCase,
    this._getNotificationStateUseCase,
    this._toggleNotificationUseCase,
  ) : super(ProfileState());

  void doEvent(ProfileEvent event) {
    switch (event) {
      case GetProfileDate():
        _getProfileData();
        break;
      case ToggleNotificationEvent():
        _toggleNotification(event);
    }
  }

  Future<void> _toggleNotification(ToggleNotificationEvent event) async {
    if (event.value == true) {
      emit(state.copyWith(isNotificationOn: true));
      _toggleNotificationUseCase.call(event.userId, true);
    } else {
      emit(state.copyWith(isNotificationOn: false));
      _toggleNotificationUseCase.call(event.userId, false);
    }
  }

  Future<void> _getProfileData() async {
    emit(state.copyWith(isNotificationOn: _getNotificationStateUseCase.call()));

    emit(state.copyWith(getProfileDatePram: const BaseState.loading()));
    final response = await _getProfileDataUseCase();
    switch (response) {
      case Success<ProfileEntity>():
        emit(
          state.copyWith(getProfileDatePram: BaseState.success(response.data)),
        );
        break;
      case Error<ProfileEntity>(:final exception):
        emit(state.copyWith(getProfileDatePram: BaseState.error(exception)));
        break;
    }
  }
}
