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

<<<<<<< HEAD
import '../../features/best_seller/api/api_client/best_seller_api_client.dart'
    as _i618;
import '../../features/best_seller/api/data_sources/best_seller_remote_data_source_impl.dart'
    as _i395;
import '../../features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart'
    as _i850;
import '../../features/best_seller/data/repo/best_seller_repo_impl.dart'
    as _i1026;
import '../../features/best_seller/domain/repo/best_seller_repo_contract.dart'
    as _i949;
import '../../features/best_seller/domain/use_cases/get_best_seller_products_use_case.dart'
    as _i573;
import '../../features/best_seller/presentation/view_model/cubit/best_seller_view_model.dart'
    as _i935;
import '../../features/categories/api/api_client/categories_api_client.dart'
    as _i612;
import '../../features/categories/api/data_source/get_categories_data_source_impl.dart'
    as _i587;
import '../../features/categories/data/datasources/get_categories_data_source.dart'
    as _i764;
import '../../features/categories/data/repositories/get_categories_impl.dart'
    as _i247;
import '../../features/categories/domain/repositories/get_categories_contract.dart'
    as _i618;
import '../../features/categories/domain/use_cases/get_all_categories_usecase.dart'
    as _i126;
import '../../features/categories/domain/use_cases/get_products_by_category_usecase.dart'
    as _i584;
import '../../features/categories/presentation/view_model/cubit/categories_cubit.dart'
    as _i806;
import '../../features/forget_password/api/forget_password_client.dart'
    as _i730;
import '../../features/forget_password/data/data_source/forget_password_data_source_contract.dart'
    as _i492;
import '../../features/forget_password/data/data_source/forget_password_data_source_impl.dart'
    as _i164;
import '../../features/forget_password/data/repository/forget_password_repo_impl.dart'
    as _i346;
import '../../features/forget_password/domain/repository/forget_password_repo_contract.dart'
    as _i308;
import '../../features/forget_password/domain/use_case/forget_password_use_case.dart'
    as _i427;
import '../../features/forget_password/domain/use_case/reset_password_use_case.dart'
    as _i292;
import '../../features/forget_password/domain/use_case/verfy_email_use_case.dart'
    as _i920;
import '../../features/forget_password/presentation/view_model/cubit/forget_password_view_model.dart'
    as _i656;
import '../../features/home/api/home_api_client/home_api_client.dart' as _i866;
import '../../features/home/data/data_source/home_remote_data_source_contract.dart'
    as _i936;
import '../../features/home/data/data_source/home_remote_data_source_impl.dart'
    as _i238;
import '../../features/home/data/repo_impl/home_repo_impl.dart' as _i886;
import '../../features/home/domain/home_use_case/best_seller_use_case.dart'
    as _i839;
import '../../features/home/domain/home_use_case/category_use_case.dart'
    as _i834;
import '../../features/home/domain/home_use_case/occasion_use_case.dart'
    as _i925;
import '../../features/home/domain/repo_contract/home_repo_contract.dart'
    as _i817;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
import '../../features/login/api/api_client/login_api_client.dart' as _i395;
import '../../features/login/api/data_sources/login_data_sources_local_impl.dart'
    as _i797;
import '../../features/login/api/data_sources/login_data_sources_remote_impl.dart'
    as _i601;
import '../../features/login/data/data_sources/login_data_sources_local_contract.dart'
    as _i251;
import '../../features/login/data/data_sources/login_data_sources_remote_contract.dart'
    as _i378;
import '../../features/login/data/repo/login_repo_impl.dart' as _i176;
import '../../features/login/domain/repo/login_repo_contract.dart' as _i180;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/presentation/view_model/cubit/login_view_model.dart'
    as _i705;
import '../../features/occasions/api/api_client/occasions_api_client.dart'
    as _i1066;
import '../../features/occasions/api/data_sources/occasions_data_sources_impl.dart'
    as _i722;
import '../../features/occasions/data/data_sources/occasions_data_sources_contract.dart'
    as _i758;
import '../../features/occasions/data/repo/occasions_repo_impl.dart' as _i85;
import '../../features/occasions/domain/repo/occasions_repo_contract.dart'
    as _i405;
import '../../features/occasions/domain/use_cases/get_occasions_use_case.dart'
    as _i569;
import '../../features/occasions/domain/use_cases/get_products_of_specific_occasion_use_case.dart'
    as _i694;
import '../../features/occasions/presentation/view_model/cubit/occasion_view_model.dart'
    as _i516;
import '../../features/register/api/api_client/register_api_client.dart'
    as _i656;
import '../../features/register/api/data_source/register_data_source_imp.dart'
    as _i495;
import '../../features/register/data/data_sources/register_data_source.dart'
    as _i984;
import '../../features/register/data/repo/register_repository_imp.dart'
    as _i897;
import '../../features/register/domain/repo/register_repository.dart' as _i668;
import '../../features/register/domain/use_case/register_use_case.dart'
    as _i217;
import '../../features/register/presentation/cubit/register_cubit.dart'
    as _i266;
=======
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
>>>>>>> origin/feature/search
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
<<<<<<< HEAD
    gh.lazySingleton<_i612.CategoriesApiClient>(
      () => coreInjectableModule.categoriesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i618.BestSellerApiClient>(
      () => _i618.BestSellerApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i730.ForgetPasswordClient>(
      () => _i730.ForgetPasswordClient(gh<_i361.Dio>()),
    );
    gh.factory<_i866.HomeApiClient>(() => _i866.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i395.LoginApiClient>(
      () => _i395.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1066.OccasionsApiClient>(
      () => _i1066.OccasionsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i656.RegisterApiClient>(
      () => _i656.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i764.GetCategoriesDataSourceContract>(
      () => _i587.GetCategoriesDataSourceImpl(gh<_i612.CategoriesApiClient>()),
    );
    gh.factory<_i251.LoginDataSourcesLocalContract>(
      () => _i797.LoginDataSourcesLocalImpl(
        flutterSecureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
=======
    gh.factory<_i599.SearchApiClient>(
      () => _i599.SearchApiClient(gh<_i361.Dio>()),
>>>>>>> origin/feature/search
    );
    gh.singleton<_i781.AuthInterceptor>(
      () => _i781.AuthInterceptor(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i758.OccasionsDataSourcesContract>(
      () => _i722.OccasionsDataSourcesImpl(
        apiClient: gh<_i1066.OccasionsApiClient>(),
      ),
    );
    gh.factory<_i984.RegisterDataSource>(
      () => _i495.RegisterDataSourceImpl(
        registerApiClient: gh<_i656.RegisterApiClient>(),
      ),
    );
    gh.factory<_i794.LocaleThemeCubit>(
      () => _i794.LocaleThemeCubit(gh<_i42.SharedPrefHelper>()),
    );
    gh.factory<_i936.HomeRemoteDataSourceContract>(
      () => _i238.HomeRemoteDataSourceImpl(gh<_i866.HomeApiClient>()),
    );
    gh.factory<_i668.RegisterRepository>(
      () => _i897.RegisterRepositoryImpl(gh<_i984.RegisterDataSource>()),
    );
    gh.factory<_i492.ForgetPasswordDataSourceContract>(
      () => _i164.ForgetPasswordDataSourceImpl(
        client: gh<_i730.ForgetPasswordClient>(),
      ),
    );
    gh.factory<_i378.LoginDataSourcesRemoteContract>(
      () => _i601.LoginDataSourcesRemoteImpl(gh<_i395.LoginApiClient>()),
    );
    gh.factory<_i180.LoginRepoContract>(
      () => _i176.LoginRepoImpl(
        remoteDataSource: gh<_i378.LoginDataSourcesRemoteContract>(),
        localDataSource: gh<_i251.LoginDataSourcesLocalContract>(),
      ),
    );
    gh.factory<_i850.BestSellerRemoteDataSourceContract>(
      () => _i395.BestSellerRemoteDataSourceImpl(
        apiClient: gh<_i618.BestSellerApiClient>(),
      ),
    );
    gh.factory<_i405.OccasionsRepoContract>(
      () => _i85.OccasionsRepoImpl(
        dataSources: gh<_i758.OccasionsDataSourcesContract>(),
      ),
    );
    gh.factory<_i157.UserHelper>(
      () => _i157.UserHelper(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
<<<<<<< HEAD
    gh.factory<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(repo: gh<_i180.LoginRepoContract>()),
    );
    gh.factory<_i308.ForgetPasswordRepoContract>(
      () => _i346.ForgetPasswordRepoImpl(
        gh<_i492.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i817.HomeRepoContract>(
      () => _i886.HomeRepoImpl(gh<_i936.HomeRemoteDataSourceContract>()),
    );
    gh.lazySingleton<_i618.GetCategoriesContract>(
      () =>
          _i247.GetCategoriesImpl(gh<_i764.GetCategoriesDataSourceContract>()),
    );
    gh.factory<_i427.ForgetPasswordUseCase>(
      () => _i427.ForgetPasswordUseCase(gh<_i308.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i292.ResetPasswordUseCase>(
      () => _i292.ResetPasswordUseCase(gh<_i308.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i920.VerifyEmailUseCase>(
      () => _i920.VerifyEmailUseCase(gh<_i308.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i569.GetOccasionsUseCase>(
      () => _i569.GetOccasionsUseCase(repo: gh<_i405.OccasionsRepoContract>()),
    );
    gh.factory<_i694.GetProductsOfSpecificOccasionUseCase>(
      () => _i694.GetProductsOfSpecificOccasionUseCase(
        repo: gh<_i405.OccasionsRepoContract>(),
      ),
    );
    gh.factory<_i217.RegisterUseCase>(
      () => _i217.RegisterUseCase(gh<_i668.RegisterRepository>()),
    );
    gh.factory<_i516.OccasionViewModel>(
      () => _i516.OccasionViewModel(
        gh<_i569.GetOccasionsUseCase>(),
        gh<_i694.GetProductsOfSpecificOccasionUseCase>(),
      ),
    );
    gh.lazySingleton<_i126.GetAllCategoriesUseCase>(
      () => _i126.GetAllCategoriesUseCase(gh<_i618.GetCategoriesContract>()),
    );
    gh.lazySingleton<_i584.GetProductsByCategoryUseCase>(
      () =>
          _i584.GetProductsByCategoryUseCase(gh<_i618.GetCategoriesContract>()),
    );
    gh.factory<_i705.LoginViewModel>(
      () => _i705.LoginViewModel(gh<_i191.LoginUseCase>()),
    );
    gh.factory<_i949.BestSellerRepoContract>(
      () => _i1026.BestSellerRepoImpl(
        remoteDataSourceContract:
            gh<_i850.BestSellerRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i839.GetBestSellerUseCase>(
      () => _i839.GetBestSellerUseCase(gh<_i817.HomeRepoContract>()),
    );
    gh.factory<_i834.GetCategoriesUseCase>(
      () => _i834.GetCategoriesUseCase(gh<_i817.HomeRepoContract>()),
    );
    gh.factory<_i925.GetOccasionsUseCase>(
      () => _i925.GetOccasionsUseCase(gh<_i817.HomeRepoContract>()),
    );
    gh.factory<_i656.ForgetPasswordViewModel>(
      () => _i656.ForgetPasswordViewModel(
        gh<_i427.ForgetPasswordUseCase>(),
        gh<_i920.VerifyEmailUseCase>(),
        gh<_i292.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i266.RegisterCubit>(
      () => _i266.RegisterCubit(gh<_i217.RegisterUseCase>()),
    );
    gh.factory<_i806.CategoriesCubit>(
      () => _i806.CategoriesCubit(
        gh<_i126.GetAllCategoriesUseCase>(),
        gh<_i584.GetProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i573.GetBestSellerProductsUseCase>(
      () => _i573.GetBestSellerProductsUseCase(
        repo: gh<_i949.BestSellerRepoContract>(),
      ),
    );
    gh.factory<_i940.HomeViewModel>(
      () => _i940.HomeViewModel(
        gh<_i834.GetCategoriesUseCase>(),
        gh<_i839.GetBestSellerUseCase>(),
        gh<_i925.GetOccasionsUseCase>(),
      ),
    );
    gh.factory<_i935.BestSellerViewModel>(
      () => _i935.BestSellerViewModel(gh<_i573.GetBestSellerProductsUseCase>()),
=======
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
>>>>>>> origin/feature/search
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
