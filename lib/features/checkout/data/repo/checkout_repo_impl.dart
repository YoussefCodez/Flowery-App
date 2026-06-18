import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowery/features/checkout/data/models/checkout_session_response_model.dart';
import 'package:flowery/features/checkout/domain/entities/checkout_entity.dart';
import 'package:flowery/features/checkout/domain/repo/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepoContract)
class CheckoutRepoImpl implements CheckoutRepoContract {
  final CheckoutRemoteDataSourceContract dataSource;
  CheckoutRepoImpl(this.dataSource);
  @override
  Future<Result<CheckoutEntity>> checkOutSession() async {
    final response = await dataSource.checkOutSession();

    switch (response) {
      case Success<CheckoutSessionResponseModel>():
        return Success<CheckoutEntity>(data: response.data?.session?.toDomain());
      case Error<CheckoutSessionResponseModel>():
        return Error<CheckoutEntity>(exception: response.exception);
    }
  }
}
