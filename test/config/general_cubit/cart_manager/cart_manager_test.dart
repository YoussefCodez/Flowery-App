import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_events.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_state.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flowery/features/cart/domain/entities/product_entity.dart';
import 'package:flowery/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/delete_specific_cart_item_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/get_user_cart_products_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/update_specific_cart_item_quantity_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserCartProductsUseCase extends Mock
    implements GetUserCartProductsUseCase {}

class MockDeleteSpecificCartItemUseCase extends Mock
    implements DeleteSpecificCartItemUseCase {}

class MockUpdateSpecificCartItemQuantityUseCase extends Mock
    implements UpdateSpecificCartItemQuantityUseCase {}

class MockAddToCartUseCase extends Mock implements AddToCartUseCase {}

void main() {
  late CartManager cubit;

  late MockGetUserCartProductsUseCase getCartUseCase;
  late MockDeleteSpecificCartItemUseCase deleteUseCase;
  late MockUpdateSpecificCartItemQuantityUseCase updateUseCase;
  late MockAddToCartUseCase addToCartUseCase;

  const errorMessage = "Something went wrong";

  final cart = CartEntity(
    cartItems: [
      CartItemEntity(
        quantity: 2,
        product: ProductEntity(
          productId: "product_1",
          title: "Red Roses Bouquet",
          description: "A beautiful bouquet of fresh red roses.",
          imgCover: "https://example.com/red_roses.jpg",
          price: 125,
        ),
      ),
      CartItemEntity(
        quantity: 1,
        product: ProductEntity(
          productId: "product_2",
          title: "White Lily Bouquet",
          description: "Elegant white lilies for special occasions.",
          imgCover: "https://example.com/white_lilies.jpg",
          price: 300,
        ),
      ),
    ],
    numberOfCartItems: 3,
    totalPriceBeforeDiscount: 550,
    discount: 50,
    totalPriceAfterDiscount: 500,
  );

  setUp(() {
    getCartUseCase = MockGetUserCartProductsUseCase();
    deleteUseCase = MockDeleteSpecificCartItemUseCase();
    updateUseCase = MockUpdateSpecificCartItemQuantityUseCase();
    addToCartUseCase = MockAddToCartUseCase();

    cubit = CartManager(
      getCartUseCase,
      deleteUseCase,
      updateUseCase,
      addToCartUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test("Initial state", () {
    expect(cubit.state, const CartState());
  });

  group("Load Cart", () {
    blocTest<CartManager, CartState>(
      "Success",
      build: () {
        when(
          () => getCartUseCase(),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetUserCartProductsEvent()),
      expect: () => [
        const CartState(isLoadingCart: true, errorMessage: ""),
        CartState(cart: cart),
      ],
      verify: (_) {
        verify(() => getCartUseCase()).called(1);
      },
    );

    blocTest<CartManager, CartState>(
      "Failure",
      build: () {
        when(() => getCartUseCase()).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetUserCartProductsEvent()),
      expect: () => [
        const CartState(isLoadingCart: true, errorMessage: ""),
        CartState(errorMessage: Exception(errorMessage).toString(), cart: null),
      ],
      verify: (_) {
        verify(() => getCartUseCase()).called(1);
      },
    );
  });

  group("Add To Cart", () {
    blocTest<CartManager, CartState>(
      "Success",
      build: () {
        when(
          () => addToCartUseCase("1", 2),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(AddToCartEvent(productId: "1", quantity: 2)),
      verify: (_) {
        verify(() => addToCartUseCase("1", 2)).called(1);
      },
    );

    blocTest<CartManager, CartState>(
      "Failure",
      build: () {
        when(() => addToCartUseCase("1", 2)).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(AddToCartEvent(productId: "1", quantity: 2)),
      verify: (_) {
        verify(() => addToCartUseCase("1", 2)).called(1);
      },
    );
  });

  group("Delete Item", () {
    blocTest<CartManager, CartState>(
      "Success",
      build: () {
        when(
          () => deleteUseCase("1"),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(DeleteSpecificCartItemEvent(productId: "1")),
      verify: (_) {
        verify(() => deleteUseCase("1")).called(1);
      },
    );

    blocTest<CartManager, CartState>(
      "Failure",
      build: () {
        when(() => deleteUseCase("1")).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(DeleteSpecificCartItemEvent(productId: "1")),
      verify: (_) {
        verify(() => deleteUseCase("1")).called(1);
      },
    );
  });

  group("Update Quantity", () {
    blocTest<CartManager, CartState>(
      "Success",
      build: () {
        when(
          () => updateUseCase("1", 5),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
        return cubit;
      },
      act: (cubit) => cubit.doEvent(
        UpdateSpecificCartItemEvent(productId: "1", quantity: 5),
      ),
      verify: (_) {
        verify(() => updateUseCase("1", 5)).called(1);
      },
    );

    blocTest<CartManager, CartState>(
      "Failure",
      build: () {
        when(() => updateUseCase("1", 5)).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(
        UpdateSpecificCartItemEvent(productId: "1", quantity: 5),
      ),
      verify: (_) {
        verify(() => updateUseCase("1", 5)).called(1);
      },
    );

    blocTest<CartManager, CartState>(
      "Quantity <= 0 calls delete",
      build: () {
        when(
          () => deleteUseCase("1"),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
        return cubit;
      },
      act: (cubit) => cubit.doEvent(
        UpdateSpecificCartItemEvent(productId: "1", quantity: 0),
      ),
      verify: (_) {
        verifyNever(() => updateUseCase(any(), any()));
        verify(() => deleteUseCase("1")).called(1);
      },
    );
  });
}
