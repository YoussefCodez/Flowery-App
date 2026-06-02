import '../../../../config/base_response/base_response.dart';
import '../models/response_model/best_seller_model.dart';
import '../models/response_model/category_model.dart';
import '../models/response_model/home_response_model.dart';
import '../models/response_model/occasion_model.dart';

abstract class HomeRemoteDataSourceContract {
  // Future<Result<List<Category>>> getCategories();
  // Future<Result<List<BestSeller>>> getBestSellers();
  // Future<Result<List<Occasion>>> getOccasions();
  Future<Result<HomeResponseModel>> getHomeData();


}