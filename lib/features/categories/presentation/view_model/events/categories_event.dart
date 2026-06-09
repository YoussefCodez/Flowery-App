sealed class CategoriesEvent {}

class GetAllCategoriesEvent extends CategoriesEvent {}

class GetProductsByCategoryEvent extends CategoriesEvent {
  final String? categoryId;
  GetProductsByCategoryEvent([this.categoryId]);
}
