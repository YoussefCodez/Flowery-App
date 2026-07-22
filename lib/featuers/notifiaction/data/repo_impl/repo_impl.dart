import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entity/notifcation_entity.dart';
import '../../domain/repo_contract/repo_contract.dart';
import '../data_source/notification_remote_data_source_contract.dart';
import '../models/notification_response_model.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<NotificationEntity>>> getNotifications() async {
    final response = await _remoteDataSource.getNotifications();

    switch (response) {
      case Success<List<NotificationResponseModel>>():
        return Success(
          data: response.data
              ?.map((notification) => notification.toDomain())
              .toList(),
        );

      case Error<List<NotificationResponseModel>>():
        return Error(
          exception: response.exception,
        );
    }
  }
}