import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response_model.dart';

abstract interface class ChangePasswordRemoteDataSourcesContract {
  Future<Result<ChangePasswordResponseModel>> changePassword(
    String oldPassword,
    String newPassword,
  );
}
