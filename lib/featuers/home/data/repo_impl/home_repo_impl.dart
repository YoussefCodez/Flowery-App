import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/data/data_source/home_remote_data_source_contract.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/home_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo_contract/home_repo_contract.dart';
import '../models/response_model/home_response_model.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract {
  final HomeRemoteDataSourceContract remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);

  @override
  Future<Result<HomeEntity>> getHomeData() async {
    final response = await remoteDataSource.getHomeData();
    switch (response) {
      case Success<HomeResponseModel>():
        return Success<HomeEntity>(
          data: HomeEntity(
            categories: response.data?.categories?.map((e) => e.toDomain()).toList(),
            bestSeller: response.data?.bestSeller?.map((e) => e.toDomain()).toList(),
            occasions: response.data?.occasions?.map((e) => e.toDomain()).toList(),
          ),
        );
      case Error<HomeResponseModel>(:final exception):
        return Error<HomeEntity>(exception: exception);
    }
  }
}
