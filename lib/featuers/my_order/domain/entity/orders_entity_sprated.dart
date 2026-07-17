import 'order_item_entity.dart';

class OrdersEntity {
  final List<OrderItemEntity> activeOrders;
  final List<OrderItemEntity> completedOrders;

  const OrdersEntity({
    required this.activeOrders,
    required this.completedOrders,
  });
}