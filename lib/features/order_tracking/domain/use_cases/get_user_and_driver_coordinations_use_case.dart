import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/order_tracking/data/data_sources/order_tracking_remote_data_source.dart';
import 'package:flowery/features/order_tracking/data/models/coordinates_information.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserAndDriverCoordinationsUseCase {
  final OrderTrackingRemoteDataSource dataSource;
  GetUserAndDriverCoordinationsUseCase(this.dataSource);

  Stream<Result<CoordinatesInformation?>> call(String? orderId) {
    return dataSource.getCoordinatesOfUserAndDriver(orderId);
  }
}
