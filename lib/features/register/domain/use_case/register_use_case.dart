import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/repo/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase(this.registerRepository);

  Future<Result<RegisterEntity>> call(RegisterRequestModel request) {
    return registerRepository.register(request);
  }
}
