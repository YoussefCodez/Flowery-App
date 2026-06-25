import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';

import '../../../../config/base_response/base_response.dart';

abstract class RemoteDataSourceContract {

  Future<Result<MyOrderResponseModel>> getMyOrderData();
}