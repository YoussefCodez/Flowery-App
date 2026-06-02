import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/data_source/home_remote_data_source_contract.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo_contract/home_repo_contract.dart';
import '../models/response_model/home_response_model.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract {
  final HomeRemoteDataSourceContract remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);
  Future<Result<HomeResponseModel>> _getHomeData() =>
      remoteDataSource.getHomeData();
  @override
  Future<Result<List<BestSellerEntity>>> getBestSeller() async {
    final response = await _getHomeData();
    switch (response) {
      case Success<HomeResponseModel>():
        return Success<List<BestSellerEntity>>(
          data: response.data?.bestSeller?.map((e) => e.toDomain()).toList(),
        );
      case Error<HomeResponseModel>(:final exception):
        return Error<List<BestSellerEntity>>(exception: exception);
    }
  }

  @override
  Future<Result<List<CategoryEntity>>> getCategory() async {
    final response = await _getHomeData();
    switch (response) {
      case Success<HomeResponseModel>():
        return Success<List<CategoryEntity>>(
          data: response.data?.categories?.map((e) => e.toDomain()).toList(),
        );
      case Error<HomeResponseModel>(:final exception):
        return Error<List<CategoryEntity>>(exception: exception);
    }
  }

  @override
  Future<Result<List<OccasionEntity>>> getOccasion() async {
    final response = await _getHomeData();
    switch (response) {
      case Success<HomeResponseModel>():
        return Success<List<OccasionEntity>>(
          data: response.data?.occasions?.map((e) => e.toDomain()).toList(),
        );
      case Error<HomeResponseModel>(:final exception):
        return Error<List<OccasionEntity>>(exception: exception);
    }
  }
}
