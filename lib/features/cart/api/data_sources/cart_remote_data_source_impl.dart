import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/cart_values.dart';
import 'package:flowery/features/cart/api/api_client/cart_api_client.dart';
import 'package:flowery/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flowery/features/cart/data/models/responses/cart_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract {
  final CartApiClient apiClient;
  CartRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<CartResponseModel>> getUserCartProducts() async {
    try {
      final response = await apiClient.getUserCartProducts();
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(e.response?.data[CartValues.error]),
      );
    }
  }

  @override
  Future<Result<CartResponseModel>> deleteSpecificItem(
    String cartItemId,
  ) async {
    try {
      final response = await apiClient.deleteSpecificItem(cartItemId);
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(e.response?.data[CartValues.error]),
      );
    }
  }

  @override
  Future<Result<CartResponseModel>> updateCartProductQuantity(
    String cartItemId,
    int quantity,
  ) async {
    try {
      final response = await apiClient.updateCartProductQuantity(cartItemId, {
        CartValues.quantity: quantity,
      });
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(e.response?.data[CartValues.error]),
      );
    }
  }
  
  @override
  Future<Result<CartResponseModel>> addToCart(String cartItemId, int quantity) async {
    try {
      final response = await apiClient.addToCart({
        CartValues.product: cartItemId,
        CartValues.quantity: quantity,
      });
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(e.response?.data[CartValues.error]),
      );
    }
  }
  
  @override
  Future<Result<CartResponseModel>> deleteUserCart() async{
    try {
      final response = await apiClient.deleteUserCart();
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(e.response?.data[CartValues.error]),
      );
    }
  }
}
