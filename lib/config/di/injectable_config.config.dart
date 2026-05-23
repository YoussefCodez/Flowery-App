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

import '../../features/app_language_logout/api/logout_api_service.dart'
    as _i884;
import '../../features/app_language_logout/data/data_sources/logout_remote_data_source.dart'
    as _i117;
import '../../features/app_language_logout/data/repositories/logout_repository_impl.dart'
    as _i395;
import '../../features/app_language_logout/domain/repositories/logout_repository.dart'
    as _i122;
import '../../features/app_language_logout/domain/use_cases/logout_use_case.dart'
    as _i443;
import '../../features/app_language_logout/presntation/cubit/logout_cubit.dart'
    as _i773;
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
    gh.lazySingleton<_i884.LogoutApiService>(
      () => coreInjectableModule.logoutApiService(gh<_i361.Dio>()),
    );
    gh.singleton<_i781.AuthInterceptor>(
      () => _i781.AuthInterceptor(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i117.LogoutRemoteDataSource>(
      () => _i117.LogoutRemoteDataSourceImpl(gh<_i884.LogoutApiService>()),
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
    gh.factory<_i122.LogoutRepository>(
      () => _i395.LogoutRepositoryImpl(
        gh<_i117.LogoutRemoteDataSource>(),
        gh<_i157.UserHelper>(),
      ),
    );
    gh.factory<_i443.LogoutUseCase>(
      () => _i443.LogoutUseCase(gh<_i122.LogoutRepository>()),
    );
    gh.factory<_i773.LogoutCubit>(
      () => _i773.LogoutCubit(gh<_i443.LogoutUseCase>()),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
