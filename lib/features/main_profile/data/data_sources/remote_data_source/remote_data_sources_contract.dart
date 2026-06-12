import 'package:flowery/features/main_profile/api/main_profile_api_client.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../model/user_response_model.dart';

abstract class ProfileRemoteDataSourceContract{
  ProfileRemoteDataSourceContract(MainProfileApiClient mainProfileApiClient);

  Future<Result<User>> getProfileDate();

}