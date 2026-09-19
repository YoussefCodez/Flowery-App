import 'package:flowery/features/register/data/models/responce/register_response.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';

extension ToEntity on RegisterResponseModel {
  RegisterEntity toEntity() {
    return RegisterEntity(message: message, user: user, token: token);
  }
}
