import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@singleton
class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Important Notifications',
    description: 'هذه القناة تستخدم للإشعارات المهمة',
    importance: Importance.high,
  );

  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print(' المستخدم وافق على الإشعارات');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print(' صلاحية مؤقتة (iOS فقط)');
    } else {
      print(' المستخدم رفض الإشعارات');
    }
  }

  // 2. جلب الـ FCM Token
  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    return token;
  }

  // 3. تهيئة flutter_local_notifications (النسخة 22.x - named parameters)
  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _localNotifications.initialize(settings: initSettings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    print(' Local notifications initialized');
  }

  int _notificationId = 0;

  Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      print(' جاري رسم الإشعار محليًا: ${notification.title}');
      await _localNotifications.show(
        id: _notificationId++,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    } else {
      print(' الرسالة وصلت بدون notification_service payload (data-only message)');
    }
  }

  // 5. استقبال الإشعارات والتطبيق فاتح (Foreground)
  void listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(' إشعار وصل والتطبيق فاتح: ${message.notification?.title}');
      _showLocalNotification(message);
    });
  }

  void listenToBackgroundTap() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(' المستخدم دوس على الإشعار: ${message.data}');
    });
  }

  void initListeners() {
    listenToForegroundMessages();
    listenToBackgroundTap();
  }
}