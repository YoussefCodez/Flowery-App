import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/domain/entities/best_seller_product_entity.dart';
import 'package:flowery/features/domain/use_cases/get_best_seller_products_use_case.dart';
import 'package:flowery/features/presentation/view_model/events/best_seller_events.dart';
import 'package:flowery/features/presentation/view_model/states/best_seller_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerViewModel extends Cubit<BestSellerStates> {
  final GetBestSellerProductsUseCase _getBestSellerProductsUseCase;
  BestSellerViewModel(this._getBestSellerProductsUseCase)
    : super(BestSellerInitState());

  void doEvent(BestSellerEvents event) {
    switch (event) {
      case GetBestSellerProductsEvent():
        _getBestSellerProducts();
    }
  }

  Future<void> _getBestSellerProducts() async {
    emit(BestSellerLoadingState());

    final response = await _getBestSellerProductsUseCase.call();

    switch (response) {
      case Success<List<BestSellerProductEntity>>():
        emit(BestSellerSuccessState(products: response.data!));
      case Error<List<BestSellerProductEntity>>():
        emit(BestSellerErrorState());
    }
  }
}
