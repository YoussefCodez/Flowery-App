import '../../../../../config/base_response/base_response.dart';
import '../../model/user_response_model.dart';

abstract interface class ProfileRemoteDataSourceContract {
  Future<Result<User>> getProfileDate();
}