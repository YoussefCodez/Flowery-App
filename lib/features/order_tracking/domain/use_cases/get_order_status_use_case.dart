import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/order_tracking/data/data_sources/order_tracking_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderStatusUseCase {
  final OrderTrackingRemoteDataSource dataSource;
  GetOrderStatusUseCase(this.dataSource);

  Stream<Result<String?>> call(String? orderId) {
    return dataSource.getOrderStatus(orderId);
  }
}
