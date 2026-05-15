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

import '../../feature/search/api/search_api_client.dart' as _i599;
import '../../feature/search/data/repo_impl/search_repo_impl.dart' as _i711;
import '../../feature/search/data/search_remote_data/search_remote_data_contract.dart'
    as _i911;
import '../../feature/search/data/search_remote_data/search_remote_data_impl.dart'
    as _i49;
import '../../feature/search/domain/repo_contract/search_repo_contract.dart'
    as _i481;
import '../../feature/search/domain/search_use_case/search_use_case.dart'
    as _i1044;
import '../../feature/search/presentation/view_model/search_cubit.dart'
    as _i453;
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
    gh.factory<_i599.SearchApiClient>(
      () => _i599.SearchApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i781.AuthInterceptor>(
      () => _i781.AuthInterceptor(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
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
    gh.factory<_i911.SearchRemoteDataSourceContract>(
      () => _i49.SearchRemoteDataSourceImpl(gh<_i599.SearchApiClient>()),
    );
    gh.factory<_i481.SearchRepoContract>(
      () => _i711.SearchRepoImpl(gh<_i911.SearchRemoteDataSourceContract>()),
    );
    gh.factory<_i1044.SearchProductsUseCase>(
      () => _i1044.SearchProductsUseCase(gh<_i481.SearchRepoContract>()),
    );
    gh.factory<_i453.SearchViewModel>(
      () => _i453.SearchViewModel(gh<_i1044.SearchProductsUseCase>()),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
