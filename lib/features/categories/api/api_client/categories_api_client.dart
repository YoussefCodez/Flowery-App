import 'package:dio/dio.dart';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/features/categories/data/models/category_response_model.dart';
import 'package:flowery/features/categories/data/models/product_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_client.g.dart';

@RestApi()
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio, {String baseUrl}) = _CategoriesApiClient;

  @GET(AppEndPoints.categories)
  Future<CategoryResponseModel> getAllCategories();

  @GET(AppEndPoints.products)
  Future<ProductResponseModel> getProductsByCategory(
    @Query('category') String? categoryId,
    @Query('sort') String? sortOption,
  );
}
