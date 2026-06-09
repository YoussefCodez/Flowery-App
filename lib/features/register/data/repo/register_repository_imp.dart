import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/register/data/data_sources/register_data_source.dart';
import 'package:flowery/features/register/data/mapper/register_mapper.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flowery/features/register/domain/repo/register_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource registerDataSource;

  RegisterRepositoryImpl(this.registerDataSource);

  @override
  Future<Result<RegisterEntity>> register(
    RegisterRequestModel request,
  ) async {
    final response = await registerDataSource.register(request);

    return response.when(
      success: (data) {
        return Success<RegisterEntity>(
          data: data?.toEntity(),
        );
      },
      error: (exception) {
        return Error<RegisterEntity>(
          exception: exception,
        );
      },
    );
  }
}