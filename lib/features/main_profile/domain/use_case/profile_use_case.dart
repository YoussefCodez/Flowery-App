import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/main_profile/domain/profile_repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDataUseCase {
  GetProfileDataUseCase(this.profileRepoContract);
  final ProfileRepoContract profileRepoContract;

  Future<Result<ProfileEntity>>call()async{
    return await profileRepoContract.getProfileData();
  }



}