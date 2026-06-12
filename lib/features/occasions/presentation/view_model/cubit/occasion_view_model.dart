import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_occasions_use_case.dart';
import 'package:flowery/features/occasions/domain/use_cases/get_products_of_specific_occasion_use_case.dart';
import 'package:flowery/features/occasions/presentation/view_model/events/occasions_events.dart';
import 'package:flowery/features/occasions/presentation/view_model/states/occasions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionViewModel extends Cubit<OccasionsState> {
  // All the usecases in occasions screen
  final GetOccasionsUseCase _getOccasionsUseCase;
  final GetProductsOfSpecificOccasionUseCase
  _getProductsOfSpecificOccasionUseCase;

  OccasionViewModel(
    this._getOccasionsUseCase,
    this._getProductsOfSpecificOccasionUseCase,
  ) : super(OccasionsState());

  void doEvent(OccasionsEvents event, {String? occasionId = ''}) {
    switch (event) {
      case GetOccasionsEvent():
        _getOccasions(occasionId: occasionId);
      case GetProductsOfSpecificOccasion():
        _getProductsOfSpecificOccasion(occasionId: occasionId);
    }
  }

  Future<void> _getOccasions({required String? occasionId}) async {
    print("I AM IN _getOccasions");
    emit(state.copyWith(isLoadingOccasions: true, errorMessage: null));

    final response = await _getOccasionsUseCase.call();

    switch (response) {
      case Success<List<OccasionEntity>>():
        final names =
            response.data?.map((occasion) => occasion.name).toList() ?? [];
        final ids =
            response.data?.map((occasion) => occasion.id).toList() ?? [];
        emit(state.copyWith(isLoadingOccasions: false, names: names, ids: ids));

        // fetch the first occasion prodcuts
        if (ids.isNotEmpty && (occasionId == "" || occasionId == null)) {
          _getProductsOfSpecificOccasion(occasionId: ids[0]);
        }

        // Responsible for navigating @Home -> Specific Occasion
        if (occasionId != null && occasionId != "") {
          _getProductsOfSpecificOccasion(occasionId: occasionId);
        }
        return;
      case Error<List<OccasionEntity>>():
        emit(
          state.copyWith(
            isLoadingOccasions: false,
            errorMessage: response.exception.toString(),
          ),
        );
        return;
    }
  }

  Future<void> _getProductsOfSpecificOccasion({
    required String? occasionId,
  }) async {
    emit(state.copyWith(isLoadingProducts: true, errorMessage: null));

    final response = await _getProductsOfSpecificOccasionUseCase.call(
      occasionId ?? "",
    );

    switch (response) {
      case Success<List<ProductEntity>>():
        emit(state.copyWith(isLoadingProducts: false, products: response.data));
        return;
      case Error<List<ProductEntity>>():
        emit(
          state.copyWith(
            isLoadingProducts: false,
            errorMessage: response.exception.toString(),
          ),
        );
        return;
    }
  }
}
