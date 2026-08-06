import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/home_entity.dart';

abstract interface class HomeRepoContract {
  Future<Result<HomeEntity>> getHomeData();
}
