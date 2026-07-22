import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entity/notifcation_entity.dart';
import '../repo_contract/repo_contract.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<Result<List<NotificationEntity>>> call() {
    return _repository.getNotifications();
  }
}