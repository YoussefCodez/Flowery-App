import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/feature/search/data/model/product_model.dart';
import 'package:flowery/feature/search/data/repo_impl/search_repo_impl.dart';
import 'package:flowery/feature/search/data/search_remote_data/search_remote_data_contract.dart';
import 'package:flowery/feature/search/domain/search_entity/product_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'search_repo_impl_test.mocks.dart';

@GenerateMocks([SearchRemoteDataSourceContract])
void main() {
  late SearchRepoImpl repoImpl;
  late MockSearchRemoteDataSourceContract mockDataSourse;

  setUp(() {
    provideDummy<Result<List<Product>>>(Success<List<Product>>(data: []));

    mockDataSourse = MockSearchRemoteDataSourceContract();
    repoImpl = SearchRepoImpl(mockDataSourse);
  });

  test('Succsess with data', () async {
    when(mockDataSourse.searchProducts(search: 'rose')).thenAnswer(
      (_) async => Success<List<Product>>(
        data: [Product(id: '1', title: 'Rose', price: 150)],
      ),
    );

    final result = await repoImpl.searchProducts(search: 'rose');

    expect(result, isA<Success<List<ProductEntity>>>());
    expect((result as Success<List<ProductEntity>>).data, isNotEmpty);
    expect((result).data?.length, 1);
    expect((result).data?[0].id, '1');
    expect((result).data?[0].title, 'Rose');
    expect((result).data?[0].price, 150);
  });

  test('Succsess without data', () async {
    when(
      mockDataSourse.searchProducts(search: 'rose'),
    ).thenAnswer((_) async => Success<List<Product>>(data: []));

    final result = await repoImpl.searchProducts(search: 'rose');
    expect(result, isA<Success<List<ProductEntity>>>());
    expect((result as Success<List<ProductEntity>>).data, isEmpty);
  });

  test('Error', () async {
    when(
      mockDataSourse.searchProducts(search: 'rose'),
    ).thenAnswer((_) async => Error<List<Product>>(exception: Exception()));

    final result = await repoImpl.searchProducts(search: 'rose');
    expect(result, isA<Error<List<ProductEntity>>>());
    expect((result as Error<List<ProductEntity>>).exception, isNotNull);
  });
}
