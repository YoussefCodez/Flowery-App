import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/feature/search/domain/search_entity/product_entity.dart';
import 'package:flowery/feature/search/domain/search_use_case/search_use_case.dart';
import 'package:flowery/feature/search/presentation/view_model/search_cubit.dart';
import 'package:flowery/feature/search/presentation/view_model/search_event.dart';
import 'package:flowery/feature/search/presentation/view_model/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_cubit_test.mocks.dart';

@GenerateMocks([SearchProductsUseCase])
void main() {
  late SearchViewModel viewModel;
  late MockSearchProductsUseCase mockSearchProductsUseCase;

  final fakeProducts = [ProductEntity(id: '1', title: 'Rose', price: 150)];

  setUp(() {
    provideDummy<Result<List<ProductEntity>>>(
      Success<List<ProductEntity>>(data: []),
    );
    mockSearchProductsUseCase = MockSearchProductsUseCase();
    viewModel = SearchViewModel(mockSearchProductsUseCase);
  });

  tearDown(() => viewModel.close());

  // ══════════════════════════════════════════════
  // السيناريو الأول: search فاضي
  // ══════════════════════════════════════════════
  blocTest<SearchViewModel, SearchState>(
    'يـ emit initial لما الـ search يكون فاضي',
    build: () => viewModel,
    act: (bloc) => bloc.doEvent(SearchProductsEvent('')),
    expect: () => [
      predicate<SearchState>((s) => s.searchState.state == StateType.initial),
    ],
  );

  // ══════════════════════════════════════════════
  // السيناريو التاني: ClearSearchEvent
  // ══════════════════════════════════════════════
  blocTest<SearchViewModel, SearchState>(
    'يـ emit initial لما ClearSearchEvent يتبعت',
    build: () => viewModel,
    act: (bloc) => bloc.doEvent(ClearSearchEvent()),
    expect: () => [
      predicate<SearchState>((s) => s.searchState.state == StateType.initial),
    ],
  );

  // ══════════════════════════════════════════════
  // السيناريو التالت: search ناجح بعد الـ debounce
  // ══════════════════════════════════════════════
  blocTest<SearchViewModel, SearchState>(
    'يـ emit loading ثم success بعد 700ms',
    build: () {
      when(mockSearchProductsUseCase(search: 'rose')).thenAnswer(
        (_) async => Success<List<ProductEntity>>(data: fakeProducts),
      );
      return viewModel;
    },
    act: (bloc) async {
      bloc.doEvent(SearchProductsEvent('rose'));
      // استنى الـ debounce يخلص
      await Future.delayed(const Duration(milliseconds: 800));
    },
    expect: () => [
      predicate<SearchState>((s) => s.searchState.state == StateType.loading),
      predicate<SearchState>((s) => s.searchState.state == StateType.success),
    ],
  );

  // ══════════════════════════════════════════════
  // السيناريو الرابع: search فاشل بعد الـ debounce
  // ══════════════════════════════════════════════
  blocTest<SearchViewModel, SearchState>(
    'يـ emit loading ثم error بعد 700ms',
    build: () {
      when(mockSearchProductsUseCase(search: 'rose')).thenAnswer(
        (_) async => Error<List<ProductEntity>>(exception: Exception('error')),
      );
      return viewModel;
    },
    act: (bloc) async {
      bloc.doEvent(SearchProductsEvent('rose'));
      await Future.delayed(const Duration(milliseconds: 800));
    },
    expect: () => [
      predicate<SearchState>((s) => s.searchState.state == StateType.loading),
      predicate<SearchState>((s) => s.searchState.state == StateType.error),
    ],
  );

  // ══════════════════════════════════════════════
  // السيناريو الخامس: الـ debounce بيلغي الـ requests المتكررة
  // ══════════════════════════════════════════════
  blocTest<SearchViewModel, SearchState>(
    'مش بيعمل call لو الـ user لسه بيكتب',
    build: () => viewModel,
    act: (bloc) async {
      bloc.doEvent(SearchProductsEvent('r'));
      bloc.doEvent(SearchProductsEvent('ro'));
      bloc.doEvent(SearchProductsEvent('ros'));
      // مستنيش 700ms — الـ debounce هيتلغى
    },
    expect: () => [], // مفيش states اتبعتت
    verify: (_) =>
        verifyNever(mockSearchProductsUseCase(search: anyNamed('search'))),
  );
}
