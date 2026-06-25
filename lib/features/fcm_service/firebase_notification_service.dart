import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@singleton
class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late NotificationSettings settings;
  Future<void> initialize() async {
    settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<bool> isNotificationPermissionAccepted() async {
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return true;
      case AuthorizationStatus.denied:
        return false;
      case AuthorizationStatus.notDetermined:
        return true;
      case AuthorizationStatus.provisional:
        return true;
    }
  }

  Future<String?> getFCMToken() async {
    return await _messaging.getToken();
  }

  Future<void> openNotificationSettings() async {
  await openAppSettings();
}
}
