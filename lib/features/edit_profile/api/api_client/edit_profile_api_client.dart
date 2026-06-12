import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/edit_profile/data/models/responses/get_user_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @GET(AppEndPoints.getLoggedUserData)
  Future<GetUserResponseModel> getCurrentUser();

  @PUT(AppEndPoints.editUserProfile)
  Future<GetUserResponseModel> editCurrentUserProfile({@Body() required Map<String, dynamic> newEdits});

    @PUT(AppEndPoints.uploadPhoto)
  Future<GetUserResponseModel> uploadPhoto({@Body() required FormData? photo});
}
