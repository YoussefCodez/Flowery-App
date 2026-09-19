import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/order_tracking/data/models/coordinates_information.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_order_information_use_case.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_order_status_use_case.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_user_and_driver_coordinations_use_case.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/events/order_tracking_events.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/state/order_tracking_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOrderStatusUseCase extends Mock implements GetOrderStatusUseCase {}

class MockGetOrderInformationUseCase extends Mock
    implements GetOrderInformationUseCase {}

class MockGetUserAndDriverCoordinationsUseCase extends Mock
    implements GetUserAndDriverCoordinationsUseCase {}

void main() {
  late MockGetOrderStatusUseCase mockGetOrderStatusUseCase;
  late MockGetOrderInformationUseCase mockGetOrderInformationUseCase;
  late MockGetUserAndDriverCoordinationsUseCase
  mockGetUserAndDriverCoordinationsUseCase;
  late OrderTrackingCubit cubit;

  const orderId = 'order-123';
  const orderInfo = OrderInformation(
    acceptedAt: '2026-07-28T12:00:00.000',
    driverFirstName: 'Ahmed',
    driverLastName: 'Ali',
    driverPhoto: 'https://example.com/driver.png',
    driverPhoneNumber: '+201234567890',
  );
  const coordinates = CoordinatesInformation(
    userLat: 30.0,
    userLong: 31.0,
    driverLat: 30.1,
    driverLong: 31.1,
  );

  setUp(() {
    mockGetOrderStatusUseCase = MockGetOrderStatusUseCase();
    mockGetOrderInformationUseCase = MockGetOrderInformationUseCase();
    mockGetUserAndDriverCoordinationsUseCase =
        MockGetUserAndDriverCoordinationsUseCase();

    cubit = OrderTrackingCubit(
      mockGetOrderStatusUseCase,
      mockGetOrderInformationUseCase,
      mockGetUserAndDriverCoordinationsUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('OrderTrackingCubit', () {
    blocTest<OrderTrackingCubit, OrderTrackingState>(
      'emits loading and success states when order information is fetched',
      build: () {
        when(() => mockGetOrderInformationUseCase.call(orderId)).thenAnswer(
          (_) async => const Success<OrderInformation>(data: orderInfo),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetOrderInforamtionEvent(orderId: orderId)),
      expect: () => [
        isA<OrderTrackingState>().having(
          (state) => state.orderInfoState.state,
          'orderInfoState.state',
          StateType.loading,
        ),
        isA<OrderTrackingState>().having(
          (state) => state.orderInfoState.state,
          'orderInfoState.state',
          StateType.success,
        ),
      ],
      verify: (_) {
        verify(() => mockGetOrderInformationUseCase.call(orderId)).called(1);
      },
    );

    blocTest<OrderTrackingCubit, OrderTrackingState>(
      'emits an error state when order information request fails',
      build: () {
        when(() => mockGetOrderInformationUseCase.call(orderId)).thenAnswer(
          (_) async => Error<OrderInformation>(exception: Exception('boom')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetOrderInforamtionEvent(orderId: orderId)),
      expect: () => [
        isA<OrderTrackingState>().having(
          (state) => state.orderInfoState.state,
          'orderInfoState.state',
          StateType.loading,
        ),
        isA<OrderTrackingState>().having(
          (state) => state.orderInfoState.state,
          'orderInfoState.state',
          StateType.error,
        ),
      ],
      verify: (_) {
        verify(() => mockGetOrderInformationUseCase.call(orderId)).called(1);
      },
    );

    blocTest<OrderTrackingCubit, OrderTrackingState>(
      'emits mapped status values when order status is streamed',
      build: () {
        when(() => mockGetOrderStatusUseCase.call(orderId)).thenAnswer(
          (_) => Stream.fromIterable([
            const Success<String?>(data: 'Accepted'),
            const Success<String?>(data: 'Picked'),
          ]),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetOrderStatusEvent(orderId: orderId)),
      expect: () => [
        isA<OrderTrackingState>().having(
          (state) => state.currentState,
          'currentState',
          0,
        ),
        isA<OrderTrackingState>().having(
          (state) => state.currentState,
          'currentState',
          1,
        ),
      ],
      verify: (_) {
        verify(() => mockGetOrderStatusUseCase.call(orderId)).called(1);
      },
    );

    blocTest<OrderTrackingCubit, OrderTrackingState>(
      'emits a coordinates success state when coordinates are streamed',
      build: () {
        when(
          () => mockGetUserAndDriverCoordinationsUseCase.call(orderId),
        ).thenAnswer(
          (_) => Stream.fromIterable([
            const Success<CoordinatesInformation?>(data: coordinates),
          ]),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(GetUserAndDriverCoordsEvent(orderId: orderId)),
      expect: () => [
        isA<OrderTrackingState>().having(
          (state) => state.coordsInfoState.state,
          'coordsInfoState.state',
          StateType.success,
        ),
      ],
      verify: (_) {
        verify(
          () => mockGetUserAndDriverCoordinationsUseCase.call(orderId),
        ).called(1);
      },
    );
  });

  test('trackingMapper returns the expected index for each status', () {
    expect(cubit.trackingMapper('Accepted'), 0);
    expect(cubit.trackingMapper('Picked'), 1);
    expect(cubit.trackingMapper('Out for delivery'), 2);
    expect(cubit.trackingMapper('Arrived'), 3);
    expect(cubit.trackingMapper('Delivered'), 4);
    expect(cubit.trackingMapper('unknown'), -1);
  });
}
