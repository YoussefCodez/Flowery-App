import 'package:flowery/features/main_profile/domain/profile_repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToggleNotificationUseCase {
  ToggleNotificationUseCase(this.profileRepoContract);
  final ProfileRepoContract profileRepoContract;

  void call(String userId, bool isNotificationOn) {
    return profileRepoContract.toggleNotificationInFireStore(userId, isNotificationOn);
  }
}
