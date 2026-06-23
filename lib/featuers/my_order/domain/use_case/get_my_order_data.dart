import 'package:flowery/featuers/my_order/domain/repo/my_order_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../entity/order_entity.dart';
import '../entity/order_item_entity.dart';

@injectable
class GetMyOrderData {
  final MyOrderRepoContract repo;
  GetMyOrderData(this.repo);

  Future<List<OrderItemEntity>>call({required bool isActive})async{
    final OrderEntity order = await repo.getMyOrderData();
    if (isActive) {
      // Active = isDelivered false
      return order.isDelivered == false ? order.orderItems : [];
    } else {
      // Completed = isDelivered true
      return order.isDelivered == true ? order.orderItems : [];
    }
  }
}