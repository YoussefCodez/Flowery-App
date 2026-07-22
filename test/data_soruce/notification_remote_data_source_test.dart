import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/featuers/notifiaction/data/data_source/notification_remote_data_source_impl.dart';
import 'package:flowery/featuers/notifiaction/data/models/notification_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'notification_remote_data_source_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<FirebaseFirestore>(),
    MockSpec<CollectionReference<Map<String, dynamic>>>(),
    MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
    MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
  ],
)
void main() {
  late MockFirebaseFirestore firestore;
  late MockCollectionReference collection;
  late MockQuerySnapshot snapshot;
  late MockQueryDocumentSnapshot document;

  late NotificationRemoteDataSourceImpl dataSource;

  setUp(() {
    firestore = MockFirebaseFirestore();
    collection = MockCollectionReference();
    snapshot = MockQuerySnapshot();
    document = MockQueryDocumentSnapshot();

    dataSource = NotificationRemoteDataSourceImpl(firestore);
  });

  group('NotificationRemoteDataSourceImpl', () {
    test(
      'should return Success<List<NotificationResponseModel>> when firestore succeeds',
          () async {
        // Arrange
        when(
          firestore.collection('notifications'),
        ).thenReturn(collection);

        when(
          collection.get(),
        ).thenAnswer((_) async => snapshot);

        when(snapshot.docs).thenReturn([document]);

        when(document.data()).thenReturn({
          "title": "Flowery",
          "body": "تم التسليم إلى المستخدم",
          "isRead": false,
          "createdAt": "2026-07-15 20:20:58.020884",
        });

        // Act
        final result = await dataSource.getNotifications();

        // Assert
        expect(
          result,
          isA<Success<List<NotificationResponseModel>>>(),
        );

        final success =
        result as Success<List<NotificationResponseModel>>;

        expect(success.data, isNotNull);
        expect(success.data!.length, 1);

        expect(success.data!.first.title, "Flowery");
        expect(success.data!.first.body, "تم التسليم إلى المستخدم");
        expect(success.data!.first.isRead, false);
      },
    );

    test(
      'should return Error when firestore throws FirebaseException',
          () async {
        // Arrange
        when(
          firestore.collection('notifications'),
        ).thenReturn(collection);

        when(collection.get()).thenThrow(
          FirebaseException(
            plugin: 'cloud_firestore',
            message: 'Permission denied',
          ),
        );

        // Act
        final result = await dataSource.getNotifications();

        // Assert
        expect(result, isA<Error>());
      },
    );
  });
}