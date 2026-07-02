import 'package:flowery/config/firebase/firebase_services.dart';
import 'package:injectable/injectable.dart';

@injectable
class OpenNotificationSettingsUseCase {
  final FirebaseServices firebase;
  OpenNotificationSettingsUseCase(this.firebase);

  Future<void> call() => firebase.fcm.openNotificationSettings();
}
