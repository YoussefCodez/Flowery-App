import 'dart:io';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';

sealed class EditProfileEvents {}

class GetLoggedUserEvent extends EditProfileEvents {}

class UpdateLoggedUserEvent extends EditProfileEvents {
  final EditUserModel user;
  UpdateLoggedUserEvent(this.user);
}

class UploadProfilePhotoEvent extends EditProfileEvents {
  final File photo;
  UploadProfilePhotoEvent(this.photo);
}
