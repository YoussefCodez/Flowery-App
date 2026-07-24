import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowery/config/firebase/firebase_module.dart';
import 'package:flowery/config/firebase/services/fcm_service.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class MockFcmService extends Mock implements FcmService {}

void main() {
  late MockFirestoreService firestoreService;
  late MockFcmService fcmService;

  setUp(() {
    firestoreService = MockFirestoreService();
    fcmService = MockFcmService();
  });

  test('should initialize FirebaseServices correctly', () {
    final firebaseServices = FirebaseServices(
      firestoreService,
      fcmService,
    );

    expect(firebaseServices.firestore, firestoreService);
    expect(firebaseServices.fcm, fcmService);
  });
}