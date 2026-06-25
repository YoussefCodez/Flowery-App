import 'package:flowery/featuers/my_order/domain/repo/my_order_repo_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../entity/order_entity.dart';
import '../entity/order_item_entity.dart';

@injectable
class GetMyOrderData {
  final MyOrderRepoContract repo;
  GetMyOrderData(this.repo);

  Future<List<OrderItemEntity>> call({required bool isActive}) async {
    final List<OrderEntity> orders = await repo.getMyOrderData();
    debugPrint("📦 Total orders: ${orders.length}");
    debugPrint("✅ Active orders: ${orders.where((o) => !o.isDelivered).length}");
    debugPrint("✅ Completed orders: ${orders.where((o) => o.isDelivered).length}");
    return orders
        .where((order) => isActive
        ? order.isDelivered == false
        : order.isDelivered == true)
        .expand((order) => order.orderItems)
        .toList();
  }
}