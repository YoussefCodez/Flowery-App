import '../../../../config/base_state/base_state.dart';
import '../../domain/search_entity/product_entity.dart';

class SearchState {
  final BaseState<List<ProductEntity>> searchState;

  SearchState({
    BaseState<List<ProductEntity>>? searchState,
  }) : searchState = searchState ?? const BaseState.initial();

  SearchState copyWith({
    BaseState<List<ProductEntity>>? searchState,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
    );
  }
}