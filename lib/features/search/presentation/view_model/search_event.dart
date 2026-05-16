abstract class SearchEvent {}

class SearchProductsEvent extends SearchEvent {
  final String search;
  SearchProductsEvent(this.search);
}

class ClearSearchEvent extends SearchEvent {}