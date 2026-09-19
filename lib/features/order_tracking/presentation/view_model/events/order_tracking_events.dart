sealed class OrderTrackingEvents {}

class GetOrderStatusEvent extends OrderTrackingEvents {
  final String? orderId;

  GetOrderStatusEvent({required this.orderId});
}

class GetUserAndDriverCoordsEvent extends OrderTrackingEvents {
  final String? orderId;

  GetUserAndDriverCoordsEvent({required this.orderId});
}

class GetOrderInforamtionEvent extends OrderTrackingEvents {
  final String? orderId;

  GetOrderInforamtionEvent({required this.orderId});
}
