import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/featuers/my_order/data/data_source/remote_data_source_contract.dart';
import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';
import 'package:flowery/featuers/my_order/data/repo/my_order_repo_impl.dart';
import 'package:flowery/featuers/my_order/domain/entity/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'my_order_repo_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSourceContract])
void main() {
  provideDummy<Result<MyOrderResponseModel>>(
    Success(data: MyOrderResponseModel()),
  );
  late MockRemoteDataSourceContract mockRemoteDataSource;
  late MyOrderRepoImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSourceContract();
    repository = MyOrderRepoImpl(mockRemoteDataSource);
  });

  final mockResponse = MyOrderResponseModel(
    orders: [],
  );

  group("MyOrderRepoImpl", () {
    test("should return Success<List<OrderEntity>>", () async {
      when(mockRemoteDataSource.getMyOrderData())
          .thenAnswer((_) async => Success(data: mockResponse));

      final result = await repository.getMyOrderData();

      expect(result, isA<Success<List<OrderEntity>>>());

      final success = result as Success<List<OrderEntity>>;

      expect(success.data, isNotNull);
      expect(success.data, isA<List<OrderEntity>>());

      verify(mockRemoteDataSource.getMyOrderData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test("should return Error<List<OrderEntity>>", () async {
      final exception = Exception("Network Error");

      when(mockRemoteDataSource.getMyOrderData())
          .thenAnswer((_) async => Error(exception: exception));

      final result = await repository.getMyOrderData();

      expect(result, isA<Error<List<OrderEntity>>>());

      final error = result as Error<List<OrderEntity>>;

      expect(error.exception, exception);

      verify(mockRemoteDataSource.getMyOrderData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}