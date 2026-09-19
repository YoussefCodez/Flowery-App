import 'package:flowery/config/base_state/base_cubit.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/app_language_logout/domain/use_cases/logout_use_case.dart';
import 'package:flowery/features/app_language_logout/presntation/cubit/logout_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutCubit extends BaseCubit<BaseState<void>, LogoutEvent, LogoutNavigation> {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(const BaseState.initial());

  @override
  Future<void> doAction(LogoutEvent event) async {
    switch (event) {
      case LogoutEvent.logout:
        await _logout();
    }
  }

  Future<void> _logout() async {
    emit(const BaseState.loading());
    try {
      await _logoutUseCase();
      emit(const BaseState.success(null));
      doNavigationAction(LogoutNavigation.goToLogin);
    } catch (e) {
      emit(BaseState.error(e is Exception ? e : Exception(e.toString())));
    }
  }
}
