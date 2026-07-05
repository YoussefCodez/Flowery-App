import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreService(this.firestore);

  Future<void> saveTokenToFirestore({
    required String userId,
    required String? token,
  }) async {
    await firestore.collection(Apikeys.users).doc(userId).set(
      {
        Apikeys.fcmToken: token,
      },
      SetOptions(merge: true),
    );
  }
}