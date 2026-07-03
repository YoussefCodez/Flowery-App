import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/best_seller/data/models/response/best_seller_products_response_model.dart';

abstract interface class BestSellerRemoteDataSourceContract {

  Future<Result<BestSellerProductsResponseModel>> getBestSellerProducts();
  
}