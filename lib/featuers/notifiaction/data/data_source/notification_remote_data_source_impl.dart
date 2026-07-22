import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../models/notification_response_model.dart';
import 'notification_remote_data_source_contract.dart';

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSource {

  final FirebaseFirestore _firestore;

  NotificationRemoteDataSourceImpl(this._firestore);

  @override
  Future<Result<List<NotificationResponseModel>>> getNotifications() async {
    try {
      final snapshot = await _firestore.collection('notifications').get();

      final notifications = snapshot.docs
          .map((e) => NotificationResponseModel.fromJson(e.data()))
          .toList();

      return Success(data: notifications);
    } on FirebaseException catch (e) {
      return Error(exception: e);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }
}