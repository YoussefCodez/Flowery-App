import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/handle_errors.dart';
import 'package:flowery/features/cart/api/api_client/cart_api_client.dart';
import 'package:flowery/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flowery/features/cart/data/models/requests/cart_request_model.dart';
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
        exception: Exception(handleError(e, null)),
      );
    }
  }

  @override
  Future<Result<CartResponseModel>> deleteSpecificItem(String productId) async {
    try {
      final response = await apiClient.deleteSpecificItem(productId);
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(handleError(e, null)),
      );
    }
  }

  @override
  Future<Result<CartResponseModel>> updateCartProductQuantity(
    String productId,
    int quantity,
  ) async {
    try {
      final response = await apiClient.updateCartProductQuantity(
        productId,
        CartRequestModel(quantity: quantity),
      );
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(handleError(e, null)),
      );
    }
  }

  @override
  Future<Result<CartResponseModel>> addToCart(
    String productId,
    int quantity,
  ) async {
    try {
      final response = await apiClient.addToCart(
        CartRequestModel(productId: productId, quantity: quantity),
      );
      return Success<CartResponseModel>(data: response);
    } on DioException catch (e) {
      return Error<CartResponseModel>(
        exception: Exception(handleError(e, null)),
      );
    }
  }
}
