// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../featuers/home/api/home_api_client/home_api_client.dart' as _i406;
import '../../featuers/home/data/data_source/home_remote_data_source_contract.dart'
    as _i794;
import '../../featuers/home/data/data_source/home_remote_data_source_impl.dart'
    as _i246;
import '../../featuers/home/data/repo_impl/home_repo_impl.dart' as _i729;
import '../../featuers/home/domain/home_use_case/get_home_data_use_case.dart'
    as _i277;
import '../../featuers/home/domain/repo_contract/home_repo_contract.dart'
    as _i633;
import '../../featuers/home/presentation/view_model/home_cubit.dart' as _i4;
import '../api/app_interceptors.dart' as _i781;
import '../general_cubit/local_cubit.dart' as _i794;
import '../helpers/shared_pref.dart' as _i42;
import '../user_helper/user_helper.dart' as _i157;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreInjectableModule = _$CoreInjectableModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreInjectableModule.prefs(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => coreInjectableModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => coreInjectableModule.secureStorage(),
    );
    gh.lazySingleton<_i361.CancelToken>(
      () => coreInjectableModule.cancelToken(),
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => coreInjectableModule.internetConnection(),
    );
    gh.factory<_i42.SharedPrefHelper>(
      () => _i42.SharedPrefHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i406.HomeApiClient>(() => _i406.HomeApiClient(gh<_i361.Dio>()));
    gh.singleton<_i781.AuthInterceptor>(
      () => _i781.AuthInterceptor(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i794.HomeRemoteDataSourceContract>(
      () => _i246.HomeRemoteDataSourceImpl(gh<_i406.HomeApiClient>()),
    );
    gh.factory<_i794.LocaleThemeCubit>(
      () => _i794.LocaleThemeCubit(gh<_i42.SharedPrefHelper>()),
    );
    gh.factory<_i157.UserHelper>(
      () => _i157.UserHelper(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i633.HomeRepoContract>(
      () => _i729.HomeRepoImpl(gh<_i794.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i277.GetHomeDataUseCase>(
      () => _i277.GetHomeDataUseCase(gh<_i633.HomeRepoContract>()),
    );
    gh.factory<_i4.HomeViewModel>(
      () => _i4.HomeViewModel(gh<_i277.GetHomeDataUseCase>()),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
