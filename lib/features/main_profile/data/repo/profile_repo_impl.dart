import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/firebase_services.dart';
import 'package:flowery/features/main_profile/data/model/user_response_model.dart';
import 'package:flowery/features/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/main_profile/domain/profile_repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/remote_data_source/remote_data_sources_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final FirebaseServices firebase;
  final ProfileRemoteDataSourceContract remoteDataSource;
  ProfileRepoImpl(this.remoteDataSource, this.firebase);
  @override
  Future<Result<ProfileEntity>> getProfileData() async {
    try {
      final response = await remoteDataSource.getProfileDate();

      switch (response) {
        case Success<User>():
          if (firebase.fcm.isNotificationPermissionAccepted()) {
            final fcmToken = await firebase.fcm.getFCMToken();

            // Handling the FCM Token null state
            if (fcmToken == null) {
              throw Exception("FCM token is null");
            }

            // In case the FCM token is not null then save it to firestore
            await firebase.firestore.saveTokenToFirestore(
              userId: response.data?.id ?? "",
              token: fcmToken,
            );

            // Listen for any FCM token refresh
            firebase.fcm.listenForFCMTokenRefresh(response.data?.id ?? "");
          } else {
            await firebase.firestore.saveTokenToFirestore(
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
      final fcmToken = await firebase.fcm.getFCMToken();
      await firebase.firestore.saveTokenToFirestore(
        userId: userId,
        token: fcmToken,
      );
      return;
    }
    await firebase.firestore.saveTokenToFirestore(userId: userId, token: null);
    return;
  }
}
