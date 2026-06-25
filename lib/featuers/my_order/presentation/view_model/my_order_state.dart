import 'package:flowery/config/base_state/base_state.dart';

import '../../domain/entity/order_item_entity.dart';

class MyOrderState {
  final BaseState<List<OrderItemEntity>> activeOrdersState;
  final BaseState<List<OrderItemEntity>> completedOrdersState;

  MyOrderState({BaseState<List<OrderItemEntity>>? activeOrdersState,BaseState<List<OrderItemEntity>>? completedOrdersState})
    : activeOrdersState = activeOrdersState ?? const BaseState.initial(),completedOrdersState = activeOrdersState ?? const BaseState.initial();

  MyOrderState copyWith({
    BaseState<List<OrderItemEntity>>? activeOrdersStatePram,
    BaseState<List<OrderItemEntity>>? completedOrdersStatePram
}){
    return MyOrderState (
      activeOrdersState: activeOrdersStatePram??this.activeOrdersState,
      completedOrdersState: completedOrdersStatePram??this.completedOrdersState,
    );
  }
}
