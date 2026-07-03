import 'package:flowery/config/base_response/base_response.dart';

import '../entity/profile_entity.dart';

abstract interface class ProfileRepoContract {
  Future<Result<ProfileEntity>> getProfileData();
  void toggleNotificationInFireStore(String userId, bool isNotificationOn);
}
