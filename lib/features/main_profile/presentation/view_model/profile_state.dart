import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';

class ProfileState {
  final BaseState<ProfileEntity> getProfileDate;

   ProfileState({
      BaseState<ProfileEntity>? getProfileDate,

   }): getProfileDate = getProfileDate ?? const BaseState.initial();

   ProfileState copyWith({
    BaseState<ProfileEntity>?getProfileDatePram

}){
     return ProfileState(
         getProfileDate: getProfileDatePram ?? getProfileDate
     );
   }

}