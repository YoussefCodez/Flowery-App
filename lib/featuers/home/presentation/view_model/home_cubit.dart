import 'package:bloc/bloc.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/best_seller_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/category_entity.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/occasion_enitity.dart';
import 'package:flowery/featuers/home/presentation/view_model/state_event.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../domain/home_use_case/best_seller_use_case.dart';
import '../../domain/home_use_case/category_use_case.dart';
import '../../domain/home_use_case/occasion_use_case.dart';
import 'home_event.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel(
      this._getCategoriesUseCase,
      this._getBestSellerUseCase,
      this._getOccasionsUseCase,
      ) : super(HomeState());

  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetBestSellerUseCase _getBestSellerUseCase;
  final GetOccasionsUseCase _getOccasionsUseCase;

  void doEvent(HomeEvent event) {
    switch (event) {
      case GetAllDataEvent():
        _callAll();
        break;
      case GetCategoriesEvent():
        _getCategories();
        break;
      case GetBestSellerEvent():
        _getBestSeller();
        break;
      case GetOccasionsEvent():
        _getOccasions();
        break;
    }
  }

  void _callAll() async {
    await Future.wait([
      _getCategories(),
      _getBestSeller(),
      _getOccasions(),
    ]);
  }

  Future<void> _getCategories() async {
    emit(state.copyWith(categoryState: const BaseState.loading()));
    final response = await _getCategoriesUseCase();
    switch (response) {
      case Success<List<CategoryEntity>>():
        emit(state.copyWith(
          categoryState: BaseState.success(response.data),
        ));
        break;
      case Error<List<CategoryEntity>>(:final exception):
        emit(state.copyWith(
          categoryState: BaseState.error(exception),
        ));
        break;
    }
  }

  Future<void> _getBestSeller() async {
    emit(state.copyWith(bestSellerState: const BaseState.loading()));
    final response = await _getBestSellerUseCase();
    switch (response) {
      case Success<List<BestSellerEntity>>():
        emit(state.copyWith(
          bestSellerState: BaseState.success(response.data),
        ));
        break;
      case Error<List<BestSellerEntity>>(:final exception):
        emit(state.copyWith(
          bestSellerState: BaseState.error(exception),
        ));
        break;
    }
  }

  Future<void> _getOccasions() async {
    emit(state.copyWith(occasionState: const BaseState.loading()));
    final response = await _getOccasionsUseCase();
    switch (response) {
      case Success<List<OccasionEntity>>():
        emit(state.copyWith(
          occasionState: BaseState.success(response.data),
        ));
        break;
      case Error<List<OccasionEntity>>(:final exception):
        emit(state.copyWith(
          occasionState: BaseState.error(exception),
        ));
        break;
    }
  }
}