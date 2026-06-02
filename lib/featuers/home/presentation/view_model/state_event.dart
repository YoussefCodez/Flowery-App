import '../../../../config/base_state/base_state.dart';
import '../../domain/home_enitiy/best_seller_entity.dart';
import '../../domain/home_enitiy/category_entity.dart';
import '../../domain/home_enitiy/occasion_enitity.dart';

class HomeState {
  final bool isLoading;
  final BaseState<List<CategoryEntity>> categoryState;
  final BaseState<List<BestSellerEntity>> bestSellerState;
  final BaseState<List<OccasionEntity>> occasionState;

  HomeState({
    this.isLoading = false,
    BaseState<List<CategoryEntity>>? categoryState,
    BaseState<List<BestSellerEntity>>? bestSellerState,
    BaseState<List<OccasionEntity>>? occasionState,
  })  : categoryState = categoryState ?? const BaseState.initial(),
        bestSellerState = bestSellerState ?? const BaseState.initial(),
        occasionState = occasionState ?? const BaseState.initial();

  HomeState copyWith({
    bool? isLoading,
    BaseState<List<CategoryEntity>>? categoryState,
    BaseState<List<BestSellerEntity>>? bestSellerState,
    BaseState<List<OccasionEntity>>? occasionState,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      categoryState: categoryState ?? this.categoryState,
      bestSellerState: bestSellerState ?? this.bestSellerState,
      occasionState: occasionState ?? this.occasionState,
    );
  }
}