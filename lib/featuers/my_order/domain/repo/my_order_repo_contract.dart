import 'package:flowery/featuers/my_order/domain/entity/order_entity.dart';

abstract class MyOrderRepoContract {
  Future<List<OrderEntity>>getMyOrderData();
}