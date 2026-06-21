import 'package:bloc/bloc.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:flowery/features/categories/domain/use_cases/get_products_by_category_usecase.dart';
import 'package:flowery/features/categories/presentation/view_model/states/categories_state.dart';
import 'package:flowery/features/categories/presentation/view_model/events/categories_event.dart';
import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  CategoriesCubit(
    this._getAllCategoriesUseCase,
    this._getProductsByCategoryUseCase,
  ) : super(CategoriesState());

  Future<void> doEvent(CategoriesEvent event) async {
    switch (event) {
      case GetAllCategoriesEvent():
        await _getAllCategories();
      case GetProductsByCategoryEvent():
        await _getProductsByCategory(event.categoryId, event.sortOption);
    }
  }

  Future<void> _getAllCategories() async {
    emit(state.copyWith(categoriesState: BaseState.loading()));
    final response = await _getAllCategoriesUseCase.call();
    switch (response) {
      case Success(data: final data):
        emit(state.copyWith(categoriesState: BaseState.success(data ?? [])));
      case Error(exception: final exception):
        if (exception is Failures) {
          emit(state.copyWith(categoriesState: BaseState.error(exception)));
        } else {
          emit(state.copyWith(categoriesState: BaseState.error(exception)));
        }
    }
  }

  Future<void> _getProductsByCategory(
    String? categoryId,
    SortOption? sortOption,
  ) async {
    if (categoryId == null || categoryId.isEmpty) {
      // Clear category -> search all products
      emit(
        state.copyWith(
          productsState: BaseState.loading(),
          selectedCategoryId: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          productsState: BaseState.loading(),
          selectedCategoryId: categoryId,
        ),
      );
    }

    final response = await _getProductsByCategoryUseCase.call(
      categoryId,
      sortOption?.sortValue,
    );

    switch (response) {
      case Success(data: final data):
        emit(state.copyWith(productsState: BaseState.success(data ?? [])));
      case Error(exception: final exception):
        if (exception is Failures) {
          emit(state.copyWith(productsState: BaseState.error(exception)));
        } else {
          emit(state.copyWith(productsState: BaseState.error(exception)));
        }
    }
  }
}
