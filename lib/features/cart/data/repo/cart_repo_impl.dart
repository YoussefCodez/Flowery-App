import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flowery/features/cart/data/models/responses/cart_response_model.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepoContract)
class CartRepoImpl implements CartRepoContract {
  final CartRemoteDataSourceContract remoteDataSource;
  CartRepoImpl({required this.remoteDataSource});

  @override
  Future<Result<CartEntity>> getUserCartProducts() async {
    final response = await remoteDataSource.getUserCartProducts();
    switch (response) {
      case Success<CartResponseModel>():
        return Success<CartEntity>(data: response.data?.cart?.toDomain());
      case Error<CartResponseModel>():
        return Error<CartEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<CartEntity>> deleteSpecificItem(String cartItemId) async {
    final response = await remoteDataSource.deleteSpecificItem(cartItemId);
    switch (response) {
      case Success<CartResponseModel>():
        return Success<CartEntity>(data: response.data?.cart?.toDomain());
      case Error<CartResponseModel>():
        return Error<CartEntity>(exception: response.exception);
    }
  }
  
  @override
  Future<Result<CartEntity>> updateCartProductQuantity(String cartItemId, int quantity) async{
    final response = await remoteDataSource.updateCartProductQuantity(cartItemId,quantity);
    switch (response) {
      case Success<CartResponseModel>():
        return Success<CartEntity>(data: response.data?.cart?.toDomain());
      case Error<CartResponseModel>():
        return Error<CartEntity>(exception: response.exception);
    }
  }
}
