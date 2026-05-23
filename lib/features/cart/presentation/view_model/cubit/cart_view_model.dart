import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/use_cases/delete_specific_cart_item_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/get_user_cart_products_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/update_specific_cart_item_quantity_use_case.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartViewModel extends Cubit<CartBaseState> {
  final GetUserCartProductsUseCase _getUserCartProductsUseCase;
  final DeleteSpecificCartItemUseCase _deleteSpecificCartItemUseCase;
  final UpdateSpecificCartItemQuantityUseCase
  _updateSpecificCartItemQuantityUseCase;
  CartViewModel(
    this._getUserCartProductsUseCase,
    this._deleteSpecificCartItemUseCase,
    this._updateSpecificCartItemQuantityUseCase,
  ) : super(CartBaseState());

  void doEvent(CartEvents event, {String cartItemId = "", int quantity = 0}) {
    switch (event) {
      case GetUserCartProductsEvent():
        _getUserCartProducts();
      case DeleteSpecificCartItemEvent():
        _deleteSpecificCartItem(cartItemId);
      case UpdateSpecificCartItemEvent():
        _updateSpecificCartItemQuantity(cartItemId, quantity);
    }
  }

  void _getUserCartProducts() async {
    emit(state.copyWith(isLoadingCart: true));
    final response = await _getUserCartProductsUseCase.call();
    switch (response) {
      case Success<CartEntity>():
        emit(state.copyWith(isLoadingCart: false, cart: response.data));
      case Error<CartEntity>():
        emit(
          state.copyWith(
            isLoadingCart: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  void _deleteSpecificCartItem(String cartItemId) async {

    final response = await _deleteSpecificCartItemUseCase.call(cartItemId);
    switch (response) {
      case Success<CartEntity>():
        emit(state.copyWith(isLoadingCart: false, cart: response.data));
      case Error<CartEntity>():
        emit(
          state.copyWith(
            isLoadingCart: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  void _updateSpecificCartItemQuantity(String cartItemId, int quantity) async {

    if (quantity <= 0) {
      _deleteSpecificCartItem(cartItemId);
    } else {
      final response = await _updateSpecificCartItemQuantityUseCase.call(
        cartItemId,
        quantity,
      );
      switch (response) {
        case Success<CartEntity>():
          emit(state.copyWith(isLoadingCart: false, cart: response.data));
        case Error<CartEntity>():
          emit(
            state.copyWith(
              isLoadingCart: false,
              errorMessage: response.exception.toString(),
            ),
          );
      }
    }
  }
}
