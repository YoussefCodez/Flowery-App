import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';

abstract class HomeRepoContract {
  Future<Result<List<CategoryEntity>>>getCategory();
  Future<Result<List<BestSellerEntity>>>getBestSeller();
  Future<Result<List<OccasionEntity>>>getOccasion();
}