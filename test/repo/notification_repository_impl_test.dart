import 'package:flowery/featuers/notifiaction/data/data_source/notification_remote_data_source_contract.dart';
import 'package:flowery/featuers/notifiaction/data/models/notification_response_model.dart';
import 'package:flowery/featuers/notifiaction/data/repo_impl/repo_impl.dart';
import 'package:flowery/featuers/notifiaction/domain/entity/notifcation_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/config/base_response/base_response.dart';


import 'notification_repository_impl_test.mocks.dart';

@GenerateMocks([NotificationRemoteDataSource])
void main() {
  late MockNotificationRemoteDataSource remoteDataSource;
  late NotificationRepositoryImpl repository;
  provideDummy<Result<List<NotificationResponseModel>>>(
    Success<List<NotificationResponseModel>>(data: []),
  );
  setUp(() {
    remoteDataSource = MockNotificationRemoteDataSource();
    repository = NotificationRepositoryImpl(remoteDataSource);
  });

  group('getNotifications', () {
    test(
      'should return Success<List<NotificationEntity>> '
          'when remote data source returns Success',
          () async {
        // Arrange
        final notifications = [
          const NotificationResponseModel(
            title: 'Flowery',
            body: 'Order delivered',
            isRead: false,
            createdAt: '2026-07-15',
          ),
        ];

        when(
          remoteDataSource.getNotifications(),
        ).thenAnswer(
              (_) async => Success(data: notifications),
        );

        // Act
        final result = await repository.getNotifications();

        // Assert
        expect(result, isA<Success<List<NotificationEntity>>>());

        final success = result as Success<List<NotificationEntity>>;

        expect(success.data, isNotNull);
        expect(success.data!.length, 1);
        expect(success.data!.first.title, 'Flowery');
        expect(success.data!.first.body, 'Order delivered');

        verify(remoteDataSource.getNotifications()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return Error when remote data source returns Error',
          () async {
        // Arrange
        final exception = Exception('Firebase Error');

        when(
          remoteDataSource.getNotifications(),
        ).thenAnswer(
              (_) async => Error(exception: exception),
        );

        // Act
        final result = await repository.getNotifications();

        // Assert
        expect(result, isA<Error<List<NotificationEntity>>>());

        final error = result as Error<List<NotificationEntity>>;

        expect(error.exception, exception);

        verify(remoteDataSource.getNotifications()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}