import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';

import '../../domain/entity/order_item_entity.dart';

class MyOrderState extends Equatable {
  final BaseState<List<OrderItemEntity>> activeOrdersState;
  final BaseState<List<OrderItemEntity>> completedOrdersState;

  const MyOrderState({
    BaseState<List<OrderItemEntity>>? activeOrdersState,
    BaseState<List<OrderItemEntity>>? completedOrdersState,
  }) : activeOrdersState =
      activeOrdersState ?? const BaseState.initial(),
        completedOrdersState =
            completedOrdersState ?? const BaseState.initial();

  MyOrderState copyWith({
    BaseState<List<OrderItemEntity>>? activeOrdersStatePram,
    BaseState<List<OrderItemEntity>>? completedOrdersStatePram,
  }) {
    return MyOrderState(
      activeOrdersState:
      activeOrdersStatePram ?? activeOrdersState,
      completedOrdersState:
      completedOrdersStatePram ?? completedOrdersState,
    );
  }

  @override
  List<Object?> get props => [
    activeOrdersState,
    completedOrdersState,
  ];
}