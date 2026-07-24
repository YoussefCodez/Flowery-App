import 'package:flowery/config/firebase/services/fcm_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationStateUseCase {
  final FcmService fcmService;
  GetNotificationStateUseCase(this.fcmService);

  bool call() => fcmService.isNotificationPermissionAccepted();
}
