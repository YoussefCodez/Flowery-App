import 'package:flowery/config/user_helper/user_helper.dart';
import 'package:flowery/features/app_language_logout/data/data_sources/logout_remote_data_source.dart';
import 'package:flowery/features/app_language_logout/domain/repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepository)
class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutRemoteDataSource _remoteDataSource;
  final UserHelper _userHelper;

  LogoutRepositoryImpl(this._remoteDataSource, this._userHelper);

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
    await _userHelper.clearUserData();
  }
}
