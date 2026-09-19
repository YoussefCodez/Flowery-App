import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:flowery/features/order_tracking/data/models/coordinates_information.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderTrackingRemoteDataSource {
  final FirestoreService firestoreService;
  OrderTrackingRemoteDataSource(this.firestoreService);

  Stream<Result<String?>> getOrderStatus(String? orderId) {
    try {
      return firestoreService.getOrderStatusStream(orderId).map((status) {
        return Success<String?>(data: status);
      });
    } catch (e) {
      return Stream.value(Error<String?>(exception: Exception(e.toString())));
    }
  }

  Stream<Result<CoordinatesInformation?>> getCoordinatesOfUserAndDriver(
    String? orderId,
  ) {
    try {
      return firestoreService.getCoordinatesOfUserAndDriver(orderId).map((
        coords,
      ) {
        return Success<CoordinatesInformation?>(data: coords);
      });
    } catch (e) {
      return Stream.value(
        Error<CoordinatesInformation?>(exception: Exception(e.toString())),
      );
    }
  }

  Future<Result<OrderInformation>> getOrderInformation(String? orderId) async {
    try {
      final response = await firestoreService.getOrderInformation(orderId);
      return Success<OrderInformation>(data: response);
    } catch (e) {
      return Error<OrderInformation>(exception: Exception(e.toString()));
    }
  }
}
