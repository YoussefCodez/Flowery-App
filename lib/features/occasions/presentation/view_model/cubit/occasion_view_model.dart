import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_occasions_use_case.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_products_of_specific_occasion_use_case.dart';
import 'package:flowery/features/occasions/presentation/view_model/events/occasions_events.dart';
import 'package:flowery/features/occasions/presentation/view_model/states/occasions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionViewModel extends Cubit<OccasionsStates> {
  final GetOccasionsUseCase _getOccasionsUseCase;
  final GetProductsOfSpecificOccasionUseCase
  _getProductsOfSpecificOccasionUseCase;
  OccasionViewModel(
    this._getOccasionsUseCase,
    this._getProductsOfSpecificOccasionUseCase,
  ) : super(OccasionsInitState());

  void doEvent(OccasionsEvents event, {String? occasionId, int? index}) {
    switch (event) {
      case GetOccasionsEvent():
        _getOccasions();
      case GetProductsOfSpecificOccasion():
        _getProductsOfSpecificOccasion(occasionId: occasionId, index: index);
    }
  }

  Future<void> _getOccasions() async {
    emit(OccasionsLoadingState());

    final response = await _getOccasionsUseCase.call();

    if (response is Success<List<OccasionEntity>>) {
      final names = response.data!.map((e) => e.name).toList();
      final ids = response.data!.map((e) => e.id).toList();

      if (state is OccasionsSuccessState) {
        emit((state as OccasionsSuccessState).copyWith(names: names, ids: ids));
      } else {
        emit(OccasionsSuccessState(names: names, ids: ids));
      }

      // Fetch the first Occasion ID
      if (ids.isNotEmpty) {
        _getProductsOfSpecificOccasion(occasionId: ids.first);
      }
    } else {
      emit(OccasionsFailedState());
    }
  }

  Future<void> _getProductsOfSpecificOccasion({
    String? occasionId,
    int? index,
  }) async {
    final response = await _getProductsOfSpecificOccasionUseCase.call(
      occasionId ?? '',
    );

    if (response is Success<List<ProductEntity>>) {
      final products = response.data!.map((e) => e).toList();

      if (state is OccasionsSuccessState) {
        emit(
          (state as OccasionsSuccessState).copyWith(
            products: products,
            selectedIndex: index,
          ),
        );
      } else {
        emit(OccasionsSuccessState(products: products));
      }
    } else {
      emit(OccasionsFailedState());
    }
  }
}
