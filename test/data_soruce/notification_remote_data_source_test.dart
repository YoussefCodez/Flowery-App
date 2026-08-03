import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/featuers/notifiaction/data/data_source/notification_remote_data_source_impl.dart';
import 'package:flowery/featuers/notifiaction/data/models/notification_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_remote_data_source_test.mocks.dart';

@GenerateMocks(
  [SharedPreferences],
  customMocks: [
    MockSpec<FirebaseFirestore>(),
    MockSpec<CollectionReference<Map<String, dynamic>>>(),
    MockSpec<Query<Map<String, dynamic>>>(),
    MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
    MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
  ],
)
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockQuery mockQuery;
  late MockQuerySnapshot mockSnapshot;
  late MockQueryDocumentSnapshot mockDocument;
  late MockSharedPreferences mockPrefs;
  late NotificationRemoteDataSourceImpl dataSource;

  const tUserId = 'user_123';

  final tDocData = {
    'title': 'Flowery',
    'body': 'تم التسليم إلى المستخدم',
    'isRead': false,
    'createdAt': '2026-07-15T20:20:58.020Z',
  };

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockQuery = MockQuery();
    mockSnapshot = MockQuerySnapshot();
    mockDocument = MockQueryDocumentSnapshot();
    mockPrefs = MockSharedPreferences();

    dataSource = NotificationRemoteDataSourceImpl(mockFirestore, mockPrefs);
  });

  group('NotificationRemoteDataSourceImpl', () {
    test(
      'should return Success with empty list when userId is null (not logged in)',
      () async {
        // arrange
        when(mockPrefs.getString(Apikeys.userId)).thenReturn(null);

        // act
        final result = await dataSource.getNotifications();

        // assert
        expect(result, isA<Success<List<NotificationResponseModel>>>());
        expect((result as Success).data, isEmpty);
        verifyNever(mockFirestore.collection(any));
      },
    );

    test(
      'should return Success with notifications filtered by userId',
      () async {
        // arrange
        when(mockPrefs.getString(Apikeys.userId)).thenReturn(tUserId);
        when(mockFirestore.collection('notifications'))
            .thenReturn(mockCollection);
        when(mockCollection.where('userId', isEqualTo: tUserId))
            .thenReturn(mockQuery);
        when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
        when(mockSnapshot.docs).thenReturn([mockDocument]);
        when(mockDocument.data()).thenReturn(tDocData);

        // act
        final result = await dataSource.getNotifications();

        // assert
        expect(result, isA<Success<List<NotificationResponseModel>>>());
        final data = (result as Success<List<NotificationResponseModel>>).data!;
        expect(data.length, 1);
        expect(data.first.title, 'Flowery');
        expect(data.first.body, 'تم التسليم إلى المستخدم');
        expect(data.first.isRead, false);
      },
    );

    test(
      'should return Success with empty list when user has no notifications',
      () async {
        // arrange
        when(mockPrefs.getString(Apikeys.userId)).thenReturn(tUserId);
        when(mockFirestore.collection('notifications'))
            .thenReturn(mockCollection);
        when(mockCollection.where('userId', isEqualTo: tUserId))
            .thenReturn(mockQuery);
        when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
        when(mockSnapshot.docs).thenReturn([]);

        // act
        final result = await dataSource.getNotifications();

        // assert
        expect(result, isA<Success<List<NotificationResponseModel>>>());
        expect((result as Success).data, isEmpty);
      },
    );

    test(
      'should return Error with ServerFailure when Firestore throws FirebaseException',
      () async {
        // arrange
        when(mockPrefs.getString(Apikeys.userId)).thenReturn(tUserId);
        when(mockFirestore.collection('notifications'))
            .thenReturn(mockCollection);
        when(mockCollection.where('userId', isEqualTo: tUserId))
            .thenReturn(mockQuery);
        when(mockQuery.get()).thenThrow(
          FirebaseException(
            plugin: 'cloud_firestore',
            message: 'Permission denied',
          ),
        );

        // act
        final result = await dataSource.getNotifications();

        // assert
        expect(result, isA<Error<List<NotificationResponseModel>>>());
        final error = result as Error<List<NotificationResponseModel>>;
        expect(error.exception, isA<ServerFailure>());
        expect(
          (error.exception as ServerFailure).errorMessage,
          'Permission denied',
        );
      },
    );

    test(
      'should query Firestore with the correct userId filter',
      () async {
        // arrange
        when(mockPrefs.getString(Apikeys.userId)).thenReturn(tUserId);
        when(mockFirestore.collection('notifications'))
            .thenReturn(mockCollection);
        when(mockCollection.where('userId', isEqualTo: tUserId))
            .thenReturn(mockQuery);
        when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
        when(mockSnapshot.docs).thenReturn([]);

        // act
        await dataSource.getNotifications();

        // assert
        verify(mockCollection.where('userId', isEqualTo: tUserId)).called(1);
      },
    );
  });
}
