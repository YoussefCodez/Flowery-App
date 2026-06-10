import 'package:flowery/features/cart/presentation/cart_manager/cart_state.dart';
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

  Future<void> loadCart() async {
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

  Future<void> addToCart(String productId, int quantity) async {
    emit(state.copyWith(isAddingToCart: true, itemId: productId));

    final response = await addToCartUseCase(productId, quantity);

    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            isAddingToCart: false,
            itemId: '',
            cart: response.data,
          ),
        );

      case Error<CartEntity>():
        emit(
          state.copyWith(
            isAddingToCart: false,
            itemId: '',
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  Future<void> deleteItem(String cartItemId) async {
    emit(state.copyWith(isDeletingCartItem: true, itemId: cartItemId));

    final response = await deleteUseCase(cartItemId);

    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            isDeletingCartItem: false,
            itemId: '',
            cart: response.data,
          ),
        );

      case Error<CartEntity>():
        emit(
          state.copyWith(
            isDeletingCartItem: false,
            itemId: '',
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }

  Future<void> updateQuantity(String cartItemId, int quantity) async {
    if (quantity == 0 || quantity < 0) {
      return deleteItem(cartItemId);
    }
    emit(state.copyWith(isUpdatingCartItem: true, itemId: cartItemId));

    final response = await updateUseCase(cartItemId, quantity);

    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            isUpdatingCartItem: false,
            itemId: '',
            cart: response.data,
          ),
        );

      case Error<CartEntity>():
        emit(
          state.copyWith(
            isUpdatingCartItem: false,
            itemId: '',
            errorMessage: response.exception.toString(),
          ),
        );
    }
  }
}
