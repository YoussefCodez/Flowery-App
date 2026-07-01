import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/register/api/api_client/register_api_client.dart';
import 'package:flowery/features/register/data/data_sources/register_data_source.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/data/models/responce/register_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImpl implements RegisterDataSource {
  final RegisterApiClient registerApiClient;

  RegisterDataSourceImpl({required this.registerApiClient});

  @override
  Future<Result<RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) async {
    try {
      final response = await registerApiClient.register(request);

      return Success<RegisterResponseModel>(
        data: response,
      );
    } catch (e) {
      return Error<RegisterResponseModel>(
        exception: Exception(e.toString()),
      );
    }
  }
}