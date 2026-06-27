import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@singleton
class FirebaseService {
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

  Future<void> saveTokenToFirestore({
    required String userId,
    required String token,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fcmToken': token,
    }, SetOptions(merge: true));
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
