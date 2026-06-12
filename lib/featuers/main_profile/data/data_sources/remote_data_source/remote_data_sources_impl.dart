import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/main_profile/api/main_profile_api_client.dart';
import 'package:flowery/featuers/main_profile/data/data_sources/remote_data_source/remote_data_sources_contract.dart';
import 'package:flowery/featuers/main_profile/data/model/profile_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../model/user_response_model.dart';
@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract{
  final MainProfileApiClient mainProfileApiClient;

  ProfileRemoteDataSourceImpl(this.mainProfileApiClient);
  @override
  Future<Result<User>> getProfileDate() async {
  try{
    final response =await mainProfileApiClient.getProfileData();
      return Success<User>(data: response.user);
  }
  catch(e){
    if (e is DioException) return Error<User>(exception: e);
    if (e is TimeoutException) return Error<User>(exception: e);
    return Error<User>(exception: Exception(e.toString()));
  }


  }

}