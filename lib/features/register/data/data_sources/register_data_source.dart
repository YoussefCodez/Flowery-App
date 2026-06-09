import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/data/models/responce/register_response.dart';

abstract class RegisterDataSource {
  Future<Result<RegisterResponseModel>> register(
    RegisterRequestModel request,
  );
}
