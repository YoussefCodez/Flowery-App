import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flowery/features/cart/domain/entities/product_entity.dart';
import 'package:flowery/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/delete_specific_cart_item_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/get_user_cart_products_use_case.dart';
import 'package:flowery/features/cart/domain/use_cases/update_specific_cart_item_quantity_use_case.dart';
import 'package:flowery/features/cart/presentation/view_model/cubit/cart_view_model.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
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
  late CartViewModel viewModel;
  late MockGetUserCartProductsUseCase mockGetUserCartProductsUseCase;
  late MockDeleteSpecificCartItemUseCase mockDeleteSpecificCartItemUseCase;
  late MockUpdateSpecificCartItemQuantityUseCase
  mockUpdateSpecificCartItemQuantityUseCase;
  late MockAddToCartUseCase mockAddToCartUseCase;

  final errorMessage = "An error has occured";

  late CartEntity cart;
  late CartItemEntity cartItem1;
  late CartItemEntity cartItem2;
  late List<CartItemEntity> cartItems;
  late CartEntity cartAfterDeletingCartItem;
  late CartEntity cartAfterUpdatingCartItem;
  late List<ProductEntity> products;

  setUp(() {
    mockGetUserCartProductsUseCase = MockGetUserCartProductsUseCase();
    mockDeleteSpecificCartItemUseCase = MockDeleteSpecificCartItemUseCase();
    mockUpdateSpecificCartItemQuantityUseCase =
        MockUpdateSpecificCartItemQuantityUseCase();
    mockAddToCartUseCase = MockAddToCartUseCase();
    viewModel = CartViewModel(
      mockGetUserCartProductsUseCase,
      mockDeleteSpecificCartItemUseCase,
      mockUpdateSpecificCartItemQuantityUseCase,
      mockAddToCartUseCase,
    );

    products = [
      ProductEntity(
        productId: '1',
        title: 'product-1',
        description: 'description',
        imgCover: 'image',
        price: 100,
      ),
      ProductEntity(
        productId: '2',
        title: 'product-2',
        description: 'description',
        imgCover: 'image',
        price: 150,
      ),
      ProductEntity(
        productId: '3',
        title: 'product-3',
        description: 'description',
        imgCover: 'image',
        price: 150,
      ),
    ];
    cartItem1 = CartItemEntity(product: products[0], quantity: 1);
    cartItem2 = CartItemEntity(product: products[1], quantity: 1);
    cartItems = [cartItem1, cartItem2];
    cart = CartEntity(
      numberOfCartItems: cartItems.length,
      totalPriceAfterDiscount: 200,
      cartItems: cartItems,
      discount: 0,
      totalPriceBeforeDiscount: 200,
    );
  });
  group("Testing getting cart", () {
    blocTest<CartViewModel, CartBaseState>(
      "Getting the cart and has products",

      // Arrange
      setUp: (() {
        when(
          () => mockGetUserCartProductsUseCase.call(),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetUserCartProductsEvent());
      },

      // Assert
      expect: () => [
        const CartBaseState(isLoadingCart: true),

        CartBaseState(isLoadingCart: false, cart: cart),
      ],

      verify: (_) {
        verify(() => mockGetUserCartProductsUseCase.call()).called(1);
      },
    );

    blocTest<CartViewModel, CartBaseState>(
      "Getting the cart but has empty products",

      // Arrange
      setUp: (() {
        cartItems = [];
        cart = CartEntity(
          numberOfCartItems: cartItems.length,
          totalPriceAfterDiscount: 0,
          cartItems: cartItems,
          discount: 0,
          totalPriceBeforeDiscount: 0,
        );

        when(
          () => mockGetUserCartProductsUseCase.call(),
        ).thenAnswer((_) async => Success<CartEntity>(data: cart));
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetUserCartProductsEvent());
      },

      // Assert
      expect: () => [
        const CartBaseState(isLoadingCart: true),

        CartBaseState(isLoadingCart: false, cart: cart),
      ],

      verify: (_) {
        verify(() => mockGetUserCartProductsUseCase.call()).called(1);
      },
    );

    blocTest<CartViewModel, CartBaseState>(
      "Error getting the cart",

      // Arrange
      setUp: (() {
        when(() => mockGetUserCartProductsUseCase.call()).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(GetUserCartProductsEvent());
      },

      // Assert
      expect: () => [
        const CartBaseState(isLoadingCart: true),

        CartBaseState(
          isLoadingCart: false,
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockGetUserCartProductsUseCase.call()).called(1);
      },
    );
  });

  group("Testing deleting a specific cart item", () {
    blocTest<CartViewModel, CartBaseState>(
      "Success in deleting a specific cart item",

      // Arrange
      setUp: (() {
        final cartItemsAfterDeleting = [cartItem1];
        cart = CartEntity(
          numberOfCartItems: cartItemsAfterDeleting.length,
          totalPriceAfterDiscount: 200,
          cartItems: cartItemsAfterDeleting,
          discount: 0,
          totalPriceBeforeDiscount: 200,
        );

        cartAfterDeletingCartItem = CartEntity(
          numberOfCartItems: cartItemsAfterDeleting.length,
          totalPriceAfterDiscount: 200,
          cartItems: cartItemsAfterDeleting,
          discount: 0,
          totalPriceBeforeDiscount: 200,
        );

        when(
          () => mockDeleteSpecificCartItemUseCase.call("cartItem2Id"),
        ).thenAnswer(
          (_) async => Success<CartEntity>(data: cartAfterDeletingCartItem),
        );
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          DeleteSpecificCartItemEvent(),
          cartItemId: "cartItem2Id",
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isDeletingCartItem: true, itemId: "cartItem2Id"),

        CartBaseState(
          isDeletingCartItem: false,
          itemId: '',
          cart: cartAfterDeletingCartItem,
        ),
      ],

      verify: (_) {
        verify(() => mockDeleteSpecificCartItemUseCase.call(any())).called(1);
      },
    );

    blocTest<CartViewModel, CartBaseState>(
      "Error deleting a specific cart item",

      // Arrange
      setUp: (() {
        when(
          () => mockDeleteSpecificCartItemUseCase.call("cartItem2Id"),
        ).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          DeleteSpecificCartItemEvent(),
          cartItemId: "cartItem2Id",
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isDeletingCartItem: true, itemId: "cartItem2Id"),

        CartBaseState(
          isDeletingCartItem: false,
          itemId: "",
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockDeleteSpecificCartItemUseCase.call(any())).called(1);
      },
    );
  });

  group("Testing updating a specific cart item", () {
    blocTest<CartViewModel, CartBaseState>(
      "Success in updating a specific cart item",

      // Arrange
      setUp: (() {
        when(
          () =>
              mockUpdateSpecificCartItemQuantityUseCase.call("cartItem2Id", 2),
        ).thenAnswer((_) async {
          cartItem2 = CartItemEntity(product: products[1], quantity: 2);
          final updateCartItems = [cartItem1, cartItem2];
          cartAfterUpdatingCartItem = CartEntity(
            numberOfCartItems: updateCartItems.length,
            totalPriceAfterDiscount: 200,
            cartItems: updateCartItems,
            discount: 0,
            totalPriceBeforeDiscount: 200,
          );
          return Success<CartEntity>(data: cartAfterUpdatingCartItem);
        });
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          UpdateSpecificCartItemEvent(),
          cartItemId: "cartItem2Id",
          quantity: 2,
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isUpdatingCartItem: true, itemId: "cartItem2Id"),

        CartBaseState(
          isUpdatingCartItem: false,
          itemId: '',
          cart: cartAfterUpdatingCartItem,
        ),
      ],

      verify: (_) {
        verify(
          () => mockUpdateSpecificCartItemQuantityUseCase.call(any(), any()),
        ).called(1);
      },
    );

    blocTest<CartViewModel, CartBaseState>(
      "Updating cart and it reached 0 quantity",

      // Arrange
      setUp: (() {
        when(
          () => mockDeleteSpecificCartItemUseCase.call("cartItem2Id"),
        ).thenAnswer((_) async {
          cartItems = [cartItem1];
          cart = CartEntity(
            numberOfCartItems: cartItems.length,
            totalPriceAfterDiscount: 200,
            cartItems: cartItems,
            discount: 0,
            totalPriceBeforeDiscount: 200,
          );
          return Success<CartEntity>(data: cart);
        });
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          UpdateSpecificCartItemEvent(),
          cartItemId: "cartItem2Id",
          quantity: 0,
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isDeletingCartItem: true, itemId: "cartItem2Id"),

        CartBaseState(isDeletingCartItem: false, itemId: "", cart: cart),
      ],

      verify: (_) {
        verify(() => mockDeleteSpecificCartItemUseCase.call(any())).called(1);
      },
    );

    blocTest<CartViewModel, CartBaseState>(
      "Error updating a specific cart item",

      // Arrange
      setUp: (() {
        when(
          () =>
              mockUpdateSpecificCartItemQuantityUseCase.call("cartItem2Id", 2),
        ).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          UpdateSpecificCartItemEvent(),
          cartItemId: "cartItem2Id",
          quantity: 2,
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isUpdatingCartItem: true, itemId: "cartItem2Id"),

        CartBaseState(
          isUpdatingCartItem: false,
          itemId: "",
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(
          () => mockUpdateSpecificCartItemQuantityUseCase.call(any(), any()),
        ).called(1);
      },
    );
  });

  group("Testing adding a specific cart item", () {
    blocTest<CartViewModel, CartBaseState>(
      "Success in adding a specific cart item",

      // Arrange
      setUp: (() {
        final cartItem3 = CartItemEntity(product: products[2], quantity: 1);
        cartItems = [cartItem1,cartItem2,cartItem3];
        cart = CartEntity(
          numberOfCartItems: cartItems.length,
          totalPriceAfterDiscount: 200,
          cartItems: cartItems,
          discount: 0,
          totalPriceBeforeDiscount: 200,
        );

        when(
          () => mockAddToCartUseCase.call("cartItem3Id",1),
        ).thenAnswer(
          (_) async => Success<CartEntity>(data: cart),
        );
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          AddToCartEvent(),
          cartItemId: "cartItem3Id",
          quantity: 1
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isAddingToCart: true, itemId: "cartItem3Id"),

        CartBaseState(
          isAddingToCart: false,
          itemId: '',
          cart: cart,
        ),
      ],

      verify: (_) {
        verify(() => mockAddToCartUseCase.call(any(),any())).called(1);
      },
    );

    blocTest<CartViewModel, CartBaseState>(
      "Error adding a specific cart item",

      // Arrange
      setUp: (() {
        when(
          () => mockAddToCartUseCase.call("cartItem3Id",1),
        ).thenAnswer(
          (_) async => Error<CartEntity>(exception: Exception(errorMessage)),
        );
      }),
      build: () => viewModel,

      // Act
      act: (viewModel) {
        viewModel.doEvent(
          AddToCartEvent(),
          cartItemId: "cartItem3Id",
          quantity: 1
        );
      },

      // Assert
      expect: () => [
        const CartBaseState(isAddingToCart: true, itemId: "cartItem3Id"),

        CartBaseState(
          isAddingToCart: false,
          itemId: "",
          errorMessage: "Exception: $errorMessage",
        ),
      ],

      verify: (_) {
        verify(() => mockAddToCartUseCase.call(any(),any())).called(1);
      },
    );
  });
}
