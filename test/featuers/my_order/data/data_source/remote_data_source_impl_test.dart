import 'package:flowery/featuers/my_order/api/my_order_api_client.dart';
import 'package:flowery/featuers/my_order/data/data_source/remote_data_source_impl.dart';
import 'package:flowery/featuers/my_order/data/model/my_order_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:mockito/mockito.dart';
import 'remote_data_source_impl_test.mocks.dart';
@GenerateMocks([MyOrderApiClient])
void main() {
  late MockMyOrderApiClient mockMyOrderApiClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockMyOrderApiClient =MockMyOrderApiClient();
    dataSource =RemoteDataSourceImpl(mockMyOrderApiClient);
  });

  final mockMyOrderResponseModel =MyOrderResponseModel();
  group("My Orders Dtat", (){
    test("Success", () async {
      when(mockMyOrderApiClient.getMyOrderData()).thenAnswer((_) async => mockMyOrderResponseModel);
       final result = await dataSource.getMyOrderData();
       
       expect(result, isA<Success<MyOrderResponseModel>>());
       expect((result as Success).data, equals(mockMyOrderResponseModel));
      verify(mockMyOrderApiClient.getMyOrderData()).called(1);
      verifyNoMoreInteractions(mockMyOrderApiClient);
       

    });
    test('should return Error with correct exception when api call fails', () async {
      final expectedException = Exception('Network error');

      when(mockMyOrderApiClient.getMyOrderData())
          .thenThrow(expectedException);

      final result = await dataSource.getMyOrderData();

      expect(result, isA<Error<MyOrderResponseModel>>());

      final errorResult = result as Error<MyOrderResponseModel>;

      expect(errorResult.exception.toString(), contains('Network error'));
    });
  });
}
