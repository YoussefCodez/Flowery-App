import 'package:flowery/features/app_language_logout/domain/repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final LogoutRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() => _repository.logout();
}
