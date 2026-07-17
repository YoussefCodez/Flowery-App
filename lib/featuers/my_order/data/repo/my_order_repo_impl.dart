import 'package:flowery/featuers/my_order/data/data_source/remote_data_source_contract.dart';
import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';
import 'package:flowery/featuers/my_order/domain/entity/order_entity.dart';
import 'package:flowery/featuers/my_order/domain/repo/my_order_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
@Injectable(as: MyOrderRepoContract)
class MyOrderRepoImpl  implements MyOrderRepoContract{
  final RemoteDataSourceContract remoteDatasource;
  MyOrderRepoImpl(this.remoteDatasource);


  @override
  Future<Result<List<OrderEntity>>> getMyOrderData() async {
    final result = await remoteDatasource.getMyOrderData();

    switch (result) {
      case Success<MyOrderResponseModel>():
        return Success(
          data: (result.data?.orders ?? [])
              .map((e) => e.toDomain())
              .toList(),
        );

      case Error<MyOrderResponseModel>():
        return Error(
          exception: result.exception,
        );
    }
  }
}