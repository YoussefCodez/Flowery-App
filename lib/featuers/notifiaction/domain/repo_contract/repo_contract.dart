import 'package:flowery/config/base_response/base_response.dart';
import '../entity/notifcation_entity.dart';

abstract class NotificationRepository {
  Future<Result<List<NotificationEntity>>> getNotifications();
}