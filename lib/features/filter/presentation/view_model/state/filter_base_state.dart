import 'package:equatable/equatable.dart';
import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';

class FilterBaseState extends Equatable {
  final SortOption? selectedSortOption;

  const FilterBaseState({this.selectedSortOption});

  FilterBaseState copyWith({SortOption? selectedSortOption}) {
    return FilterBaseState(
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
    );
  }

  @override
  List<Object?> get props => [selectedSortOption];
}
