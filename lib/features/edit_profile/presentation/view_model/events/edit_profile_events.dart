sealed class EditProfileEvents {}

class GetLoggedUserEvent extends EditProfileEvents{}

class ChangeGenderEvent extends EditProfileEvents{}

class UpdateLoggedUserEvent extends EditProfileEvents{}

class UploadProfilePhotoEvent extends EditProfileEvents{}
