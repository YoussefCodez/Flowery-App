import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/login/data/models/responses/login_response_model.dart';

abstract interface class LoginDataSourcesContract {
  Future<Result<LoginResponseModel>> login(
    String email,
    String password,
  );
}
