import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/data_source/home_remote_data_source_contract.dart';
import 'package:flowery/featuers/home/data/models/response_model/best_seller_model.dart';
import 'package:flowery/featuers/home/data/models/response_model/category_model.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/home_repo_contract.dart';
import '../data_source/home_remote_data_source_impl.dart';
import '../models/response_model/occasion_model.dart';
@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract{
  final HomeRemoteDataSourceContract remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);

  @override
  Future<Result<List<BestSellerEntity>>> getBestSeller() async {
    final response = await remoteDataSource.getBestSellers();
    switch (response) {
      case Success<List<BestSeller>>():
        return Success<List<BestSellerEntity>>(data: response.data?.map((e) => e.toDomain()).toList(),);
      case Error<List<BestSeller>>(:final exception):
        return Error<List<BestSellerEntity>>(exception: exception);
    }
  }

  @override
  Future<Result<List<CategoryEntity>>> getCategory() async {
    final response = await remoteDataSource.getCategories();
    switch (response) {
      case Success<List<Category>>():
        return Success<List<CategoryEntity>>(
          data: response.data?.map((e) => e.toDomain()).toList(),
        );
      case Error<List<Category>>(:final exception):
        return Error<List<CategoryEntity>>(exception: exception);
    }
  }

  @override
  Future<Result<List<OccasionEntity>>> getOccasion() async {
    final response = await remoteDataSource.getOccasions();
    switch (response) {
      case Success<List<Occasion>>():
        return Success<List<OccasionEntity>>(
          data: response.data?.map((e) => e.toDomain()).toList(),
        );
      case Error<List<Occasion>>(:final exception):
        return Error<List<OccasionEntity>>(exception: exception);
    }
  }
}