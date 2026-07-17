import 'package:flowery/featuers/my_order/domain/entity/order_entity.dart';

import '../../../../config/base_response/base_response.dart';

abstract interface class MyOrderRepoContract {
  Future<Result<List<OrderEntity>>>getMyOrderData();
}