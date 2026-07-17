import '../../../../config/base_response/base_response.dart';
import '../model/my_order_model.dart';

abstract interface class RemoteDataSourceContract{
  Future<Result<MyOrderResponseModel>>getMyOrderData();
}