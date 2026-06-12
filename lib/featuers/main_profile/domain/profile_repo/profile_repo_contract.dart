import 'package:flowery/config/base_response/base_response.dart';

import '../entity/profile_entity.dart';

abstract class ProfileRepoContract{

  Future<Result<ProfileEntity>>getProfileData();

}