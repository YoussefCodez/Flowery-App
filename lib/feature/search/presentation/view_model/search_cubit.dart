import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/search_entity/product_entity.dart';
import '../../domain/search_use_case/search_use_case.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel(this._searchProductsUseCase) : super(SearchState());

  final SearchProductsUseCase _searchProductsUseCase;
  Timer? _debounce;

  void doEvent(SearchEvent event) {
    switch (event) {
      case SearchProductsEvent():
        if (event.search.trim().isEmpty) {
          _debounce?.cancel();
          emit(state.copyWith(searchState: const BaseState.initial()));
          return;
        }
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          _searchProducts(event.search.trim());
        });
        break;
      case ClearSearchEvent():
        _debounce?.cancel();
        emit(state.copyWith(searchState: const BaseState.initial()));
        break;
    }
  }

  Future<void> _searchProducts(String search) async {
    emit(state.copyWith(searchState: const BaseState.loading()));
    final response = await _searchProductsUseCase(search: search);
    switch (response) {
      case Success<List<ProductEntity>>():
        emit(state.copyWith(
          searchState: BaseState.success(response.data),
        ));
        break;
      case Error<List<ProductEntity>>(:final exception):
        emit(state.copyWith(
          searchState: BaseState.error(exception),
        ));
        break;
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}