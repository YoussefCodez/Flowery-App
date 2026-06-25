import 'package:equatable/equatable.dart';
import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';

class FilterBaseState extends Equatable {
  final SortOption? selectedSortOption;
  final String? categoryId;

  const FilterBaseState({this.selectedSortOption, this.categoryId});

  FilterBaseState copyWith({
    SortOption? selectedSortOption,
    String? categoryId,
  }) {
    return FilterBaseState(
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [selectedSortOption, categoryId];
}
