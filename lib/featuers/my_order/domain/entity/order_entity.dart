import 'package:equatable/equatable.dart';

import 'order_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final List<OrderItemEntity> orderItems;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.orderItems,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    orderItems,
    createdAt,
  ];
}