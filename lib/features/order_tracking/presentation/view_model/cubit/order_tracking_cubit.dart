import 'dart:async';

import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_order_information_use_case.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_order_status_use_case.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/events/order_tracking_events.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/state/order_tracking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final GetOrderStatusUseCase _getOrderStatusUseCase;
  final GetOrderInformationUseCase _getOrderInformationUseCase;
  OrderTrackingCubit(
    this._getOrderStatusUseCase,
    this._getOrderInformationUseCase,
  ) : super(OrderTrackingState());
  StreamSubscription<Result<String?>>? _orderStatusSubscription;

  void doEvent(OrderTrackingEvents event) {
    switch (event) {
      case GetOrderStatusEvent():
        _getOrderStatus(event);
        break;
      case GetOrderInforamtionEvent():
        _getOrderInformation(event);
    }
  }

  void _getOrderInformation(GetOrderInforamtionEvent event) async {
    emit(state.copyWith(orderInfoState: BaseState.loading()));
    final response = await _getOrderInformationUseCase.call(event.orderId);
    switch (response) {
      case Success<OrderInformation>():
        emit(state.copyWith(orderInfoState: BaseState<OrderInformation>.success(response.data)));
      case Error<OrderInformation>():
        emit(
          state.copyWith(orderInfoState: BaseState<OrderInformation>.error(response.exception)),
        );
    }
  }

  void _getOrderStatus(GetOrderStatusEvent event) {
    // Cancel any existing active stream listener to prevent multiple subscriptions
    _orderStatusSubscription?.cancel();

    _orderStatusSubscription = _getOrderStatusUseCase
        .call(event.orderId)
        .listen(
          (result) {
            switch (result) {
              case Success<String?>():
                final status = trackingMapper(result.data ?? "");
                emit(state.copyWith(currentState: status, errorMessage: ""));
                break;

              case Error<String?>():
                emit(state.copyWith(errorMessage: result.exception.toString()));
                break;
            }
          },
          onError: (error) {
            emit(state.copyWith(errorMessage: error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _orderStatusSubscription?.cancel();
    return super.close();
  }

  int trackingMapper(String status) {
    if (status == Apikeys.accepted) {
      return 0;
    } else if (status == Apikeys.picked) {
      return 1;
    } else if (status == Apikeys.outForDelivery) {
      return 2;
    } else if (status == Apikeys.arrived) {
      return 3;
    } else if (status == Apikeys.delivered) {
      return 4;
    } else {
      return -1;
    }
  }
}
