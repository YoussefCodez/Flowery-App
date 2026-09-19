import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/data/models/responses/create_credit_order_response.dart';
import 'package:flowery/features/checkout/data/models/responses/create_cash_order_response.dart';
import 'package:flowery/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';
import 'package:flowery/features/checkout/domain/repo/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepoContract)
class CheckoutRepoImpl implements CheckoutRepoContract {
  final CheckoutRemoteDataSourceContract dataSource;
  CheckoutRepoImpl(this.dataSource);
  @override
  Future<Result<CreditOrderEntity>> createCreditOrder() async {
    final response = await dataSource.checkOutSession();

    switch (response) {
      case Success<CreateCreditOrderResponse>():
        return Success<CreditOrderEntity>(data: response.data?.session?.toDomain());
      case Error<CreateCreditOrderResponse>():
        return Error<CreditOrderEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<CashOrderEntity>> createCashOrder(CreateCashOrderRequest request) async{
    final response = await dataSource.createCashOrder(request);
    switch (response) {
      case Success<CreateCashOrderResponse>():
        return Success<CashOrderEntity>(data: response.data?.toEntity());
      case Error<CreateCashOrderResponse>():
        return Error<CashOrderEntity>(exception: response.exception);
    }
  }
}
