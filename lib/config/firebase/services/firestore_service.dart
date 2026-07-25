import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreService(this.firestore);

  Future<void> saveTokenToFirestore({
    required String userId,
    required String? token,
  }) async {
    await firestore.collection(Apikeys.users).doc(userId).set({
      Apikeys.fcmToken: token,
    }, SetOptions(merge: true));
  }

  Stream<String?> getOrderStatusStream(String? orderId) {
    return FirebaseFirestore.instance
        .collection(Apikeys.acceptedOrders)
        .doc(orderId)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            return snapshot.data()?[Apikeys.status] as String?;
          }
          return null;
        });
  }

  Future<OrderInformation> getOrderInformation(String? orderId) async {
    if (orderId == null) {
      throw Exception("Order ID cannot be null");
    }

    final snapshot = await FirebaseFirestore.instance
        .collection(Apikeys.acceptedOrders)
        .doc(orderId)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return OrderInformation(
        acceptedAt: data[Apikeys.acceptedAt],
        driverFirstName: data[Apikeys.firstName],
        driverLastName: data[Apikeys.lastName],
        driverPhoto: data[Apikeys.photo],
        driverPhoneNumber: data[Apikeys.phone],
      );
    }

    throw Exception("Order not found");
  }
}
