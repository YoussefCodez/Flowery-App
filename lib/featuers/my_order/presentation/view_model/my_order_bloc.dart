import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/my_order/domain/entity/order_item_entity.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_event.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entity/orders_entity_sprated.dart';
import '../../domain/use_case/get_my_order_data.dart';

@injectable
class MyOrderBloc extends Cubit<MyOrderState> {
  final GetMyOrderData _getMyOrderData;

  MyOrderBloc(this._getMyOrderData) : super(MyOrderState());
    void doEvent(MyOrderEvent event){
      debugPrint("🎯 doEvent: $event");

      switch(event){
        case GetMyOrdersData():
          _callAll();
          break;

      }
    }


  Future<void> _callAll() async {
    emit(
      state.copyWith(
        activeOrdersStatePram: BaseState.loading(),
        completedOrdersStatePram: BaseState.loading(),
      ),
    );

    final result = await _getMyOrderData();

    switch (result) {
      case Success<OrdersEntity>():
        emit(
          state.copyWith(
            activeOrdersStatePram:
            BaseState.success(result.data!.activeOrders),
            completedOrdersStatePram:
            BaseState.success(result.data!.completedOrders),
          ),
        );

      case Error<OrdersEntity>():
        emit(
          state.copyWith(
            activeOrdersStatePram:
            BaseState.error(result.exception!),
            completedOrdersStatePram:
            BaseState.error(result.exception!),
          ),
        );
    }
  }

  /*Future<void> _getActiveOrders() async {
    try {
      emit(state.copyWith(activeOrdersStatePram: BaseState.loading()));

      final data = await _getMyOrderData(isActive: true);
      emit(state.copyWith(activeOrdersStatePram: BaseState.success(data)));
    } catch (e) {
      emit(
        state.copyWith(
          activeOrdersStatePram: BaseState.error(Exception(e.toString())),
        ),
      );
    }
  }
  Future<void> _getComplateOrders() async {
    try {
      emit(state.copyWith(completedOrdersStatePram: BaseState.loading()));

      final data = await _getMyOrderData(isActive: false);
      emit(state.copyWith(completedOrdersStatePram: BaseState.success(data)));
    } catch (e) {
      emit(
        state.copyWith(
          completedOrdersStatePram: BaseState.error(Exception(e.toString())),
        ),
      );
    }
  }*/
}
