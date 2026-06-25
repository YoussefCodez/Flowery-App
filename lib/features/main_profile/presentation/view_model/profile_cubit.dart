import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/firebase/firebase_service.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/main_profile/domain/use_case/profile_use_case.dart';
import 'package:flowery/features/main_profile/presentation/view_model/profile_event.dart';
import 'package:flowery/features/main_profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseService _fcmService;
  final GetProfileDataUseCase _getProfileDataUseCase;
  ProfileCubit(this._getProfileDataUseCase, this._fcmService)
    : super(ProfileState());

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
    emit(state.copyWith(isNotificationOn: event.value));

    await getIt<FirebaseService>().openNotificationSettings();
  }

  Future<void> _getProfileData() async {
    // Set the notification from the settings
    emit(
      state.copyWith(
        isNotificationOn: await _fcmService.isNotificationPermissionAccepted(),
      ),
    );

    emit(state.copyWith(getProfileDatePram: const BaseState.loading()));
    final response = await _getProfileDataUseCase();
    switch (response) {
      case Success<ProfileEntity>():
        final String? fcmToken = await _fcmService.getFCMToken();
        await _fcmService.saveTokenToFirestore(
          userId: response.data?.id ?? "",
          token: fcmToken ?? "",
        );
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
