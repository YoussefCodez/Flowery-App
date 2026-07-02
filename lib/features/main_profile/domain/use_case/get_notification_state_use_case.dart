import 'package:flowery/config/firebase/firebase_services.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationStateUseCase {
  final FirebaseServices firebase;
  GetNotificationStateUseCase(this.firebase);

  bool call() => firebase.fcm.isNotificationPermissionAccepted();
}
