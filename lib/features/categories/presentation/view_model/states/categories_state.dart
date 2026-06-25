import 'package:equatable/equatable.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/features/categories/domain/entities/category_entity.dart';
import 'package:flowery/features/categories/domain/entities/product_entity.dart';

class CategoriesState extends Equatable {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<ProductEntity>> productsState;
  final String? selectedCategoryId;

  const CategoriesState({
    this.categoriesState = const BaseState.initial(),
    this.productsState = const BaseState.initial(),
    this.selectedCategoryId,
  });

  CategoriesState copyWith({
    BaseState<List<CategoryEntity>>? categoriesState,
    BaseState<List<ProductEntity>>? productsState,
    Object? selectedCategoryId = _noChange,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      productsState: productsState ?? this.productsState,
      selectedCategoryId: selectedCategoryId == _noChange
          ? this.selectedCategoryId
          : selectedCategoryId as String?,
    );
  }

  static const _noChange = Object();

  @override
  List<Object?> get props => [
    categoriesState,
    productsState,
    selectedCategoryId,
  ];
}
