import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';
import 'package:flowery/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:flowery/features/change_password/presentation/view_model/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/view_model/states/change_password_base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordBaseState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(ChangePasswordBaseState());

  void doEvent(
    ChangePasswordEvents event, {
    String? oldPassword,
    String? newPassword,
  }) {
    switch (event) {
      case ChangePasswordEvent():
        _changePassword(oldPassword: oldPassword, newPassword: newPassword);
    }
  }

  Future<void> _changePassword({
    String? oldPassword,
    String? newPassword,
  }) async {
    emit(state.copyWith(isChangingPassword: true));

    final response = await _changePasswordUseCase.call(
      oldPassword ?? "",
      newPassword ?? "",
    );

    switch (response) {
      case Success<ChangePasswordResponseModel>():
        emit(
          state.copyWith(
            isChangingPassword: false,
            didChangePasswordfail: false,
          ),
        );
      case Error<ChangePasswordResponseModel>():
        emit(
          state.copyWith(
            isChangingPassword: false,
            didChangePasswordfail: true,
          ),
        );
    }
  }
}
