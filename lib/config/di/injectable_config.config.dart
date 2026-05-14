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
<<<<<<< HEAD
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
=======
import '../../features/api/api_client/best_seller_api_client.dart' as _i1015;
import '../../features/api/data_sources/best_seller_remote_data_source_impl.dart'
    as _i124;
import '../../features/data/data_sources/best_seller_remote_data_source_contract.dart'
    as _i451;
import '../../features/data/repo/best_seller_repo_impl.dart' as _i759;
import '../../features/domain/repo/best_seller_repo_contract.dart' as _i1020;
import '../../features/domain/use_cases/get_best_seller_products_use_case.dart'
    as _i410;
import '../../features/presentation/view_model/cubit/best_seller_view_model.dart'
    as _i703;
>>>>>>> feature/best-seller
=======
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
>>>>>>> origin/categories_feature
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
<<<<<<< HEAD
    gh.factory<_i1066.OccasionsApiClient>(
      () => _i1066.OccasionsApiClient(gh<_i361.Dio>()),
=======
    gh.factory<_i1015.BestSellerApiClient>(
      () => _i1015.BestSellerApiClient(gh<_i361.Dio>()),
>>>>>>> feature/best-seller
    );
    gh.singleton<_i781.AuthInterceptor>(
      () => _i781.AuthInterceptor(
=======
    gh.lazySingleton<_i612.CategoriesApiClient>(
      () => coreInjectableModule.categoriesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i764.GetCategoriesDataSourceContract>(
      () => _i587.GetCategoriesDataSourceImpl(gh<_i612.CategoriesApiClient>()),
    );
    gh.singleton<_i781.AppInterceptors>(
      () => _i781.AppInterceptors(
>>>>>>> origin/categories_feature
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
<<<<<<< HEAD
    gh.factory<_i758.OccasionsDataSourcesContract>(
      () => _i722.OccasionsDataSourcesImpl(
        apiClient: gh<_i1066.OccasionsApiClient>(),
=======
    gh.factory<_i451.BestSellerRemoteDataSourceContract>(
      () => _i124.BestSellerRemoteDataSourceImpl(
        apiClient: gh<_i1015.BestSellerApiClient>(),
>>>>>>> feature/best-seller
      ),
    );
    gh.factory<_i794.LocaleThemeCubit>(
      () => _i794.LocaleThemeCubit(gh<_i42.SharedPrefHelper>()),
    );
<<<<<<< HEAD
    gh.factory<_i405.OccasionsRepoContract>(
      () => _i85.OccasionsRepoImpl(
        dataSources: gh<_i758.OccasionsDataSourcesContract>(),
      ),
    );
=======
    gh.factory<_i1020.BestSellerRepoContract>(
      () => _i759.BestSellerRepoImpl(
        remoteDataSourceContract:
            gh<_i451.BestSellerRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i410.GetBestSellerProductsUseCase>(
      () => _i410.GetBestSellerProductsUseCase(
        repo: gh<_i1020.BestSellerRepoContract>(),
      ),
    );
    gh.factory<_i703.BestSellerViewModel>(
      () => _i703.BestSellerViewModel(gh<_i410.GetBestSellerProductsUseCase>()),
    );
>>>>>>> feature/best-seller
    gh.factory<_i157.UserHelper>(
      () => _i157.UserHelper(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
<<<<<<< HEAD
    gh.factory<_i569.GetOccasionsUseCase>(
      () => _i569.GetOccasionsUseCase(repo: gh<_i405.OccasionsRepoContract>()),
    );
    gh.factory<_i694.GetProductsOfSpecificOccasionUseCase>(
      () => _i694.GetProductsOfSpecificOccasionUseCase(
        repo: gh<_i405.OccasionsRepoContract>(),
      ),
    );
    gh.factory<_i516.OccasionViewModel>(
      () => _i516.OccasionViewModel(
        gh<_i569.GetOccasionsUseCase>(),
        gh<_i694.GetProductsOfSpecificOccasionUseCase>(),
=======
    gh.lazySingleton<_i618.GetCategoriesContract>(
      () =>
          _i247.GetCategoriesImpl(gh<_i764.GetCategoriesDataSourceContract>()),
    );
    gh.lazySingleton<_i126.GetAllCategoriesUseCase>(
      () => _i126.GetAllCategoriesUseCase(gh<_i618.GetCategoriesContract>()),
    );
    gh.lazySingleton<_i584.GetProductsByCategoryUseCase>(
      () =>
          _i584.GetProductsByCategoryUseCase(gh<_i618.GetCategoriesContract>()),
    );
    gh.factory<_i806.CategoriesCubit>(
      () => _i806.CategoriesCubit(
        gh<_i126.GetAllCategoriesUseCase>(),
        gh<_i584.GetProductsByCategoryUseCase>(),
>>>>>>> origin/categories_feature
      ),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i291.CoreInjectableModule {}
