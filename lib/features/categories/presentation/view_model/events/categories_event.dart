import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';

sealed class CategoriesEvent {}

class GetAllCategoriesEvent extends CategoriesEvent {}

class GetProductsByCategoryEvent extends CategoriesEvent {
  final SortOption? sortOption;
  final String? categoryId;
  GetProductsByCategoryEvent([this.categoryId, this.sortOption]);
}
