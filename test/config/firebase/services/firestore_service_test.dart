import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late FirestoreService service;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    service = FirestoreService(firestore);
  });

  test('saveTokenToFirestore stores token', () async {
    await service.saveTokenToFirestore(
      userId: 'user123',
      token: 'token123',
    );

    final snapshot =
        await firestore.collection('users').doc('user123').get();

    expect(snapshot.exists, true);
    expect(snapshot.data()!['fcmToken'], 'token123');
  });
}