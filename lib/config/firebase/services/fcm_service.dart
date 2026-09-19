import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class FcmService {
  final FirestoreService _firestore;
  final FirebaseMessaging _messaging;

  FcmService(
    this._firestore,
    this._messaging,
  );
  // App Notification instance
  late NotificationSettings _settings;

  // FCM services
  Future<void> requestPermission() async {
    _settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<String?> getFCMToken() async {
    return await _messaging.getToken();
  }

  void listenForFCMTokenRefresh(String userId) {
    _messaging.onTokenRefresh.listen((newToken) async {
      await _firestore.saveTokenToFirestore(userId: userId, token: newToken);
    });
  }

  // App Notifications services
  bool isNotificationPermissionAccepted() {
    switch (_settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return true;
      case AuthorizationStatus.denied:
        return false;
      case AuthorizationStatus.notDetermined:
        return false;
      case AuthorizationStatus.provisional:
        return true;
    }
  }

  Future<void> openNotificationSettings() async {
    await openAppSettings();
  }
}