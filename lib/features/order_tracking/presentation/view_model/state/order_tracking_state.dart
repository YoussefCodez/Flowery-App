import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';

class OrderTrackingState extends Equatable {
  final BaseState<OrderInformation> orderInfoState;
  final int currentState;
  final String? errorMessage;

  const OrderTrackingState({
    this.currentState = -1,
    this.errorMessage,
    this.orderInfoState = const BaseState.initial(),
  });

  OrderTrackingState copyWith({
    final int? currentState,
    final String? errorMessage,
    final BaseState<OrderInformation>? orderInfoState,
  }) => OrderTrackingState(
    currentState: currentState ?? this.currentState,
    errorMessage: errorMessage ?? this.errorMessage,
    orderInfoState: orderInfoState ?? this.orderInfoState,
  );

  @override
  List<Object?> get props => [currentState, errorMessage, orderInfoState];
}
