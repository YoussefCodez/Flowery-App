import 'package:flowery/featuers/my_order/domain/repo/my_order_repo_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entity/order_entity.dart';
import '../entity/order_item_entity.dart';
import '../entity/orders_entity_sprated.dart';

@injectable
class GetMyOrderData {
  final MyOrderRepoContract repo;

  GetMyOrderData(this.repo);

  Future<Result<OrdersEntity>> call() async {
    final result = await repo.getMyOrderData();

    switch (result) {
      case  Success<List<OrderEntity>>():
      final orders = result.data ?? [];

      final activeOrders = orders
          .where((e) => !e.isDelivered)
          .expand((e) => e.orderItems)
          .toList();

      final completedOrders = orders
          .where((e) => e.isDelivered)
          .expand((e) => e.orderItems)
          .toList();

      debugPrint("========== ALL ORDERS ==========");
      for (final order in orders) {
        debugPrint(
          "Order: ${order.orderNumber} | "
              "Delivered: ${order.isDelivered} | "
              "State: ${order.state}",
        );
      }

      debugPrint("========== ACTIVE ITEMS ==========");
      for (final item in activeOrders) {
        debugPrint(item.product.title);
      }

      debugPrint("========== COMPLETED ITEMS ==========");
      for (final item in completedOrders) {
        debugPrint(item.product.title);
      }

      return Success<OrdersEntity>(
        data: OrdersEntity(
          activeOrders: activeOrders,
          completedOrders: completedOrders,
        ),
      );

      case Error<List<OrderEntity>>():
        return Error<OrdersEntity>(
          exception: result.exception,
        );
    }
  }}