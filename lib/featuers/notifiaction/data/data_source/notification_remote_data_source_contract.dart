import '../../../../config/base_response/base_response.dart';
import '../models/notification_response_model.dart';

abstract interface class NotificationRemoteDataSource {
  Future<Result<List<NotificationResponseModel>>> getNotifications();
}