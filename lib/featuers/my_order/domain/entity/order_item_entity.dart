import 'package:flowery/featuers/my_order/domain/entity/product_entity.dart';

class OrderItemEntity {
  final ProductEntity product;
  final double price;
  final int quantity;
  final String id;

  const OrderItemEntity({
    required this.product,
    required this.price,
    required this.quantity, required this.id,
  });
}