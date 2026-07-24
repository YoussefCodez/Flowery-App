import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/services/fcm_service.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:flowery/features/main_profile/data/model/user_response_model.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/main_profile/domain/profile_repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/remote_data_source/remote_data_sources_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final FcmService fcmService;
  final FirestoreService firestoreService;
  final ProfileRemoteDataSourceContract remoteDataSource;
  ProfileRepoImpl(this.remoteDataSource, this.fcmService, this.firestoreService,);
  @override
  Future<Result<ProfileEntity>> getProfileData() async {
    try {
      final response = await remoteDataSource.getProfileDate();

      switch (response) {
        case Success<User>():
          if (fcmService.isNotificationPermissionAccepted()) {
            final fcmToken = await fcmService.getFCMToken();

            // Handling the FCM Token null state
            if (fcmToken == null) {
              throw Exception(Apikeys.fcmTokenisNull);
            }

            // In case the FCM token is not null then save it to firestore
            await firestoreService.saveTokenToFirestore(
              userId: response.data?.id ?? "",
              token: fcmToken,
            );

            // Listen for any FCM token refresh
            fcmService.listenForFCMTokenRefresh(response.data?.id ?? "");
          } else {
            await firestoreService.saveTokenToFirestore(
              userId: response.data?.id ?? "",
              token: null,
            );
          }
          return Success<ProfileEntity>(data: response.data?.toDomain());
        case Error<User>(:final exception):
          return Error<ProfileEntity>(exception: exception);
      }
    } catch (e) {
      return Error<ProfileEntity>(
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  void toggleNotificationInFireStore(
    String userId,
    bool isNotificationOn,
  ) async {
    if (isNotificationOn) {
      final fcmToken = await fcmService.getFCMToken();
      await firestoreService.saveTokenToFirestore(
        userId: userId,
        token: fcmToken,
      );
      return;
    }
    await firestoreService.saveTokenToFirestore(userId: userId, token: null);
    return;
  }
}
