import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/api/api_keys.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/error/failures.dart';
import '../models/notification_response_model.dart';
import 'notification_remote_data_source_contract.dart';

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore _firestore;
  final SharedPreferences _prefs;

  NotificationRemoteDataSourceImpl(this._firestore, this._prefs);

  @override
  Future<Result<List<NotificationResponseModel>>> getNotifications() async {
    final userId = _prefs.getString(Apikeys.userId);
    if (userId == null) return const Success(data: []);

    try {
      final snapshot = await _firestore
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .get();

      final notifications = snapshot.docs
          .map((e) => NotificationResponseModel.fromJson(e.data()))
          .toList();

      return Success(data: notifications);
    } on FirebaseException catch (e) {
      return Error(
        exception: ServerFailure(errorMessage: e.message ?? 'Firebase error'),
      );
    } on Exception catch (e) {
      return Error(exception: ServerFailure(errorMessage: e.toString()));
    }
  }
}
