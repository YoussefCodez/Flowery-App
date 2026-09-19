import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/order_tracking/data/data_sources/order_tracking_remote_data_source.dart';
import 'package:flowery/features/order_tracking/data/models/coordinates_information.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:flowery/config/firebase/services/firestore_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late MockFirestoreService mockFirestoreService;
  late OrderTrackingRemoteDataSource dataSource;

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
    mockFirestoreService = MockFirestoreService();
    dataSource = OrderTrackingRemoteDataSource(mockFirestoreService);
  });

  group('OrderTrackingRemoteDataSource', () {
    test('returns a success result for order status stream', () async {
      when(
        () => mockFirestoreService.getOrderStatusStream(orderId),
      ).thenAnswer((_) => Stream.value('accepted'));

      final stream = dataSource.getOrderStatus(orderId);

      await expectLater(
        stream,
        emits(
          isA<Success<String?>>().having(
            (result) => result.data,
            'data',
            'accepted',
          ),
        ),
      );
    });

    test(
      'returns a success result for user and driver coordinates stream',
      () async {
        when(
          () => mockFirestoreService.getCoordinatesOfUserAndDriver(orderId),
        ).thenAnswer((_) => Stream.value(coordinates));

        final stream = dataSource.getCoordinatesOfUserAndDriver(orderId);

        await expectLater(
          stream,
          emits(
            isA<Success<CoordinatesInformation?>>().having(
              (result) => result.data,
              'data',
              coordinates,
            ),
          ),
        );
      },
    );

    test('returns order information successfully', () async {
      when(
        () => mockFirestoreService.getOrderInformation(orderId),
      ).thenAnswer((_) async => orderInfo);

      final result = await dataSource.getOrderInformation(orderId);

      expect(result, isA<Success<OrderInformation>>());
      expect((result as Success<OrderInformation>).data, orderInfo);
      verify(() => mockFirestoreService.getOrderInformation(orderId)).called(1);
    });

    test(
      'returns an error result when order information fetching throws',
      () async {
        when(
          () => mockFirestoreService.getOrderInformation(orderId),
        ).thenThrow(Exception('boom'));

        final result = await dataSource.getOrderInformation(orderId);

        expect(result, isA<Error<OrderInformation>>());
        expect((result as Error<OrderInformation>).exception, isA<Exception>());
      },
    );
  });
}
