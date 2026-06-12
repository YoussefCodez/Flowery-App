import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/main_profile/data/model/user_response_model.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/main_profile/domain/profile_repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/remote_data_source/remote_data_sources_contract.dart';
@Injectable(as : ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract remoteDataSource;
  ProfileRepoImpl (this.remoteDataSource);
  @override
  Future<Result<ProfileEntity>> getProfileData() async {
    final response = await remoteDataSource.getProfileDate();
    switch(response){
      case Success<User>():
        return Success<ProfileEntity>(data: response.data?.toDomain());
      case Error<User>(:final exception):
        return Error<ProfileEntity>(exception: exception);

    }

  }
}