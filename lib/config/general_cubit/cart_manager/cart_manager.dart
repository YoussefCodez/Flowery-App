import 'package:flowery/config/general_cubit/cart_manager/cart_events.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/delete_specific_cart_item_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/get_user_cart_products_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/update_specific_cart_item_quantity_use_case.dart';
import 'package:injectable/injectable.dart';

@singleton
class CartManager extends Cubit<CartState> {
  final GetUserCartProductsUseCase getCartUseCase;
  final DeleteSpecificCartItemUseCase deleteUseCase;
  final UpdateSpecificCartItemQuantityUseCase updateUseCase;
  final AddToCartUseCase addToCartUseCase;

  CartManager(
    this.getCartUseCase,
    this.deleteUseCase,
    this.updateUseCase,
    this.addToCartUseCase,
  ) : super(const CartState());

  void doEvent(CartEvents event) {
    switch (event) {
      case GetUserCartProductsEvent():
        _loadCart();
      case DeleteSpecificCartItemEvent():
        _deleteItem(event.productId);
      case UpdateSpecificCartItemEvent():
        _updateQuantity(event.productId, event.quantity);
      case AddToCartEvent():
        _addToCart(event.productId, event.quantity);
    }
  }

  Future<void> _loadCart() async {
    emit(state.copyWith(isLoading: true));

    final response = await getCartUseCase();

    switch (response) {
      case Success<CartEntity>():
        emit(state.copyWith(isLoading: false, cart: response.data));

      case Error<CartEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  Future<void> _addToCart(String productId, int quantity) async {
    final response = await addToCartUseCase(productId, quantity);

    switch (response) {
      case Success<CartEntity>():
        emit(state.copyWith(cart: response.data));

      case Error<CartEntity>():
        emit(state.copyWith(errorMessage: response.exception.toString()));
    }
  }

  Future<void> _deleteItem(String productId) async {
    final response = await deleteUseCase(productId);

    switch (response) {
      case Success<CartEntity>():
        emit(state.copyWith(cart: response.data));

      case Error<CartEntity>():
        emit(state.copyWith(errorMessage: response.exception.toString()));
    }
  }

  Future<void> _updateQuantity(String productId, int quantity) async {
    final response = await updateUseCase(productId, quantity);

    switch (response) {
      case Success<CartEntity>():
        emit(state.copyWith(cart: response.data));

      case Error<CartEntity>():
        emit(state.copyWith(errorMessage: response.exception.toString()));
    }
  }
}
