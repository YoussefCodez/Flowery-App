import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';

sealed class FilterEvents {}

class UpdateSortOptionEvent extends FilterEvents {
  final SortOption sortOption;

  UpdateSortOptionEvent({required this.sortOption});
}
