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

import '../../featuers/forget_password/api/forget_password_client.dart'
    as _i957;
import '../../featuers/forget_password/data/data_source/forget_password_data_source_contract.dart'
    as _i13;
import '../../featuers/forget_password/data/data_source/forget_password_data_source_impl.dart'
    as _i883;
import '../../featuers/forget_password/data/repository/forget_password_repo_impl.dart'
    as _i936;
import '../../featuers/forget_password/domain/repository/forget_password_repo_contract.dart'
    as _i520;
import '../../featuers/forget_password/domain/use_case/forget_password_use_case.dart'
    as _i940;
import '../../featuers/forget_password/domain/use_case/reset_password_use_case.dart'
    as _i845;
import '../../featuers/forget_password/domain/use_case/verfy_email_use_case.dart'
    as _i532;
import '../../featuers/forget_password/presentation/view_model/cubit/forget_password_view_model.dart'
    as _i114;
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
    gh.factory<_i794.LocaleThemeCubit>(() => _i794.LocaleThemeCubit());
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
    gh.factory<_i957.ForgetPasswordClient>(
      () => _i957.ForgetPasswordClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i781.AppInterceptors>(
      () => _i781.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i157.UserHelper>(
      () => _i157.UserHelper(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i13.ForgetPasswordDataSourceContract>(
      () => _i883.ForgetPasswordDataSourceImpl(
        client: gh<_i957.ForgetPasswordClient>(),
      ),
    );
    gh.factory<_i520.ForgetPasswordRepoContract>(
      () => _i936.ForgetPasswordRepoImpl(
        gh<_i13.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i940.ForgetPasswordUseCase>(
      () => _i940.ForgetPasswordUseCase(gh<_i520.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i845.ResetPasswordUseCase>(
      () => _i845.ResetPasswordUseCase(gh<_i520.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i532.VerifyEmailUseCase>(
      () => _i532.VerifyEmailUseCase(gh<_i520.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i114.ForgetPasswordViewModel>(
      () => _i114.ForgetPasswordViewModel(
        gh<_i940.ForgetPasswordUseCase>(),
        gh<_i532.VerifyEmailUseCase>(),
        gh<_i845.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
