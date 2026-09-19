import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/features/order_tracking/data/models/coordinates_information.dart';
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

  Stream<CoordinatesInformation?> getCoordinatesOfUserAndDriver(
    String? orderId,
  ) async* {
    if (orderId == null) {
      yield null;
      return;
    }

    // Get driverId and user lat and long and they are static
    final orderSnapshot = await FirebaseFirestore.instance
        .collection(Apikeys.acceptedOrders)
        .doc(orderId)
        .get();
    final orderData = orderSnapshot.data();

    final driverId = orderData![Apikeys.driverId] as String;
    final userLat = double.parse(
      orderData[Apikeys.userAddress][Apikeys.lat].toString(),
    );
    final userLong = double.parse(
      orderData[Apikeys.userAddress][Apikeys.long].toString(),
    );

    // Stream snapshots for the driver coords
    await for (final driverSnapshots
        in FirebaseFirestore.instance
            .collection(Apikeys.driverLocations)
            .doc(driverId)
            .snapshots()) {
      if (!driverSnapshots.exists || driverSnapshots.data() == null) {
        yield null;
        continue;
      }

      final driverData = driverSnapshots.data()!;

      yield CoordinatesInformation(
        userLat: userLat,
        userLong: userLong,
        driverLat: (driverData[Apikeys.lat] as num).toDouble(),
        driverLong: (driverData[Apikeys.long] as num).toDouble(),
      );
    }
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
