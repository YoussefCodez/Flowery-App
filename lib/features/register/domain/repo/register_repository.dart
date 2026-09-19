import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';

abstract class RegisterRepository {
  Future<Result<RegisterEntity>> register(RegisterRequestModel request);
}
