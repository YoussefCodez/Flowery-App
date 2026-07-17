import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/featuers/my_order/domain/entity/order_item_entity.dart';
import 'package:flowery/featuers/my_order/domain/entity/orders_entity_sprated.dart';
import 'package:flowery/featuers/my_order/domain/use_case/get_my_order_data.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_bloc.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_event.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_state.dart';

import 'my_order_bloc_test.mocks.dart';

@GenerateMocks([GetMyOrderData])
void main() {
  late MockGetMyOrderData mockGetMyOrderData;
  late MyOrderBloc bloc;
  provideDummy<Result<OrdersEntity>>(
    Success(
      data: OrdersEntity(
        activeOrders: [],
        completedOrders: [],
      ),
    ),
  );

  setUp(() {
    mockGetMyOrderData = MockGetMyOrderData();
    bloc = MyOrderBloc(mockGetMyOrderData);
  });

  group('MyOrderBloc', () {
    blocTest<MyOrderBloc, MyOrderState>(
      'emits loading then success when use case succeeds',
      build: () {
        when(mockGetMyOrderData()).thenAnswer(
              (_) async => Success(
            data: OrdersEntity(
              activeOrders: const [],
              completedOrders: const [],
            ),
          ),
        );

        return MyOrderBloc(mockGetMyOrderData);
      },
      act: (bloc) => bloc.doEvent(GetMyOrdersData()),
      expect: () => [
        isA<MyOrderState>()
            .having(
              (s) => s.activeOrdersState.state,
          'active state',
          StateType.loading,
        )
            .having(
              (s) => s.completedOrdersState.state,
          'completed state',
          StateType.loading,
        ),
        isA<MyOrderState>()
            .having(
              (s) => s.activeOrdersState.state,
          'active state',
          StateType.success,
        )
            .having(
              (s) => s.completedOrdersState.state,
          'completed state',
          StateType.success,
        ),
      ],
      verify: (_) {
        verify(mockGetMyOrderData()).called(1);
      },
    );

    blocTest<MyOrderBloc, MyOrderState>(
      'emits loading then error',
      build: () {
        when(mockGetMyOrderData()).thenAnswer(
              (_) async => Error(
            exception: Exception('Server Error'),
          ),
        );

        return bloc;
      },
      act: (bloc) => bloc.doEvent(GetMyOrdersData()),
      expect: () => [
        isA<MyOrderState>(),
        isA<MyOrderState>(),
      ],
      verify: (_) {
        verify(mockGetMyOrderData()).called(1);
      },
    );
  });
}