import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/my_order/data/data_source/remote_data_source_contract.dart';
import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';
import 'package:flowery/featuers/my_order/domain/entity/order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/my_order_repo_contract.dart';
@Injectable(as :MyOrderRepoContract )
class MyOrderRepoImpl implements MyOrderRepoContract{
  final RemoteDataSourceContract remoteDataSource;
  MyOrderRepoImpl(this.remoteDataSource);

  @override
  Future<OrderEntity> getMyOrderData() async {
    final result = await remoteDataSource.getMyOrderData();
    switch (result) {
      case Success<MyOrderResponseModel>():
        return result.data!.order!.toDomain();
      case Error<MyOrderResponseModel>():
        throw result.exception ?? Exception('Unknown error'); //
    }
  }

}