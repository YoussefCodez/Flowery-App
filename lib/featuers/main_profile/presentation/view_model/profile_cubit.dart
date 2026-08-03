import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/featuers/main_profile/domain/use_case/profile_use_case.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_event.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit  extends Cubit<ProfileState>{
  final GetProfileDataUseCase _getProfileDataUseCase;
  ProfileCubit(this._getProfileDataUseCase) : super(const ProfileState());

  void doEvent(ProfileEvent event) {
    switch (event) {
      case GetProfileDate():
        _getProfileData();
        break;

    }
  }

  Future<void>_getProfileData() async{
    emit(state.copyWith(getProfileDatePram: const BaseState.loading()));
    final response = await _getProfileDataUseCase();
    switch(response){
      case Success<ProfileEntity>():
        emit(state.copyWith(getProfileDatePram: BaseState.success(response.data)));
        break;
      case Error<ProfileEntity>(:final exception):
        emit(state.copyWith(getProfileDatePram: BaseState.error(exception)));
        break;
    }
  }
}