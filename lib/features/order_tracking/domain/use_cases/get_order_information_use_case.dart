import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/order_tracking/data/data_sources/order_tracking_remote_data_source.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderInformationUseCase {
  final OrderTrackingRemoteDataSource dataSource;
  GetOrderInformationUseCase(this.dataSource);

  Future<Result<OrderInformation>> call(String? orderId) {
    return dataSource.getOrderInformation(orderId);
  }
}
