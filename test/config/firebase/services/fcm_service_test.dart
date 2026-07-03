import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowery/config/firebase/services/fcm_service.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';

class MockFirebaseMessaging extends Mock
    implements FirebaseMessaging {}

class MockFirestoreService extends Mock
    implements FirestoreService {}

void main() {
  late MockFirebaseMessaging messaging;
  late MockFirestoreService firestoreService;
  late FcmService fcmService;

  setUp(() {
    messaging = MockFirebaseMessaging();
    firestoreService = MockFirestoreService();

    fcmService = FcmService(
      firestoreService,
      messaging,
    );
  });

  group('requestPermission', () {
    test('should request notification permission', () async {
      when(
        () => messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        ),
      ).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          alert: AppleNotificationSetting.enabled,
          announcement: AppleNotificationSetting.disabled,
          badge: AppleNotificationSetting.enabled,
          carPlay: AppleNotificationSetting.disabled,
          lockScreen: AppleNotificationSetting.enabled,
          notificationCenter: AppleNotificationSetting.enabled,
          showPreviews: AppleShowPreviewSetting.always,
          sound: AppleNotificationSetting.enabled,
          criticalAlert: AppleNotificationSetting.disabled,
          timeSensitive: AppleNotificationSetting.disabled,
          providesAppNotificationSettings:
              AppleNotificationSetting.disabled,
        ),
      );

      await fcmService.requestPermission();

      verify(
        () => messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        ),
      ).called(1);
    });
  });

  group('getFCMToken', () {
    test('should return token', () async {
      when(() => messaging.getToken())
          .thenAnswer((_) async => 'myToken');

      final token = await fcmService.getFCMToken();

      expect(token, 'myToken');

      verify(() => messaging.getToken()).called(1);
    });
  });

  group('listenForFCMTokenRefresh', () {
    test('should save refreshed token', () async {
      final controller = StreamController<String>();

      when(() => messaging.onTokenRefresh)
          .thenAnswer((_) => controller.stream);

      when(
        () => firestoreService.saveTokenToFirestore(
          userId: any(named: 'userId'),
          token: any(named: 'token'),
        ),
      ).thenAnswer((_) async {});

      fcmService.listenForFCMTokenRefresh('user123');

      controller.add('newToken');

      await Future.delayed(Duration.zero);

      verify(
        () => firestoreService.saveTokenToFirestore(
          userId: 'user123',
          token: 'newToken',
        ),
      ).called(1);

      await controller.close();
    });
  });

  group('isNotificationPermissionAccepted', () {
    test('returns true when authorized', () async {
      when(
        () => messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        ),
      ).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          alert: AppleNotificationSetting.enabled,
          announcement: AppleNotificationSetting.disabled,
          badge: AppleNotificationSetting.enabled,
          carPlay: AppleNotificationSetting.disabled,
          lockScreen: AppleNotificationSetting.enabled,
          notificationCenter: AppleNotificationSetting.enabled,
          showPreviews: AppleShowPreviewSetting.always,
          sound: AppleNotificationSetting.enabled,
          criticalAlert: AppleNotificationSetting.disabled,
          timeSensitive: AppleNotificationSetting.disabled,
          providesAppNotificationSettings:
              AppleNotificationSetting.disabled,
        ),
      );

      await fcmService.requestPermission();

      expect(fcmService.isNotificationPermissionAccepted(), isTrue);
    });

    test('returns false when denied', () async {
      when(
        () => messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        ),
      ).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.denied,
          alert: AppleNotificationSetting.disabled,
          announcement: AppleNotificationSetting.disabled,
          badge: AppleNotificationSetting.disabled,
          carPlay: AppleNotificationSetting.disabled,
          lockScreen: AppleNotificationSetting.disabled,
          notificationCenter: AppleNotificationSetting.disabled,
          showPreviews: AppleShowPreviewSetting.never,
          sound: AppleNotificationSetting.disabled,
          criticalAlert: AppleNotificationSetting.disabled,
          timeSensitive: AppleNotificationSetting.disabled,
          providesAppNotificationSettings:
              AppleNotificationSetting.disabled,
        ),
      );

      await fcmService.requestPermission();

      expect(fcmService.isNotificationPermissionAccepted(), isFalse);
    });
  });
}