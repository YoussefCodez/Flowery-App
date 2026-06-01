import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/cart_values.dart';
import 'package:flowery/features/cart/api/api_client/cart_api_client.dart';
import 'package:flowery/features/cart/api/data_sources/cart_remote_data_source_impl.dart';
import 'package:flowery/features/cart/data/models/responses/cart_item_model.dart';
import 'package:flowery/features/cart/data/models/responses/cart_model.dart';
import 'package:flowery/features/cart/data/models/responses/cart_response_model.dart';
import 'package:flowery/features/cart/data/models/responses/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartApiClient extends Mock implements CartApiClient {}

void main() {
  late CartRemoteDataSourceImpl dataSource;
  late MockCartApiClient mockApiClient;

  final cartItem1 = CartItem(id: "1",price:110 ,product: Product(),quantity: 1);
  final cartItem2 = CartItem(id: "2",price:110 ,product: Product(),quantity: 2);
  final cartItems = [cartItem1,cartItem2];
  final CartResponseModel successCartResponseModel = CartResponseModel(
    message: "success",
    cart: Cart(cartItems: cartItems),
    numOfCartItems: cartItems.length,
  );

  const errorMessage = "Something went wrong";

  setUp(() {
    mockApiClient = MockCartApiClient();

    dataSource = CartRemoteDataSourceImpl(
      apiClient: mockApiClient,
    );
  });

  DioException dioException() {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        data: {CartValues.error: errorMessage},
      ),
    );
  }

  group("Testing Get User Cart", () {
    test("Successfully getting cart", () async {
      // Arrange
      when(
        () => mockApiClient.getUserCartProducts(),
      ).thenAnswer(
        (_) async => successCartResponseModel,
      );

      // Act
      final response = await dataSource.getUserCartProducts();

      // Assert
      expect(response, isA<Success<CartResponseModel>>());

      verify(
        () => mockApiClient.getUserCartProducts(),
      ).called(1);
    });

    test("Failed getting cart", () async {
      // Arrange
      when(
        () => mockApiClient.getUserCartProducts(),
      ).thenThrow(dioException());

      // Act
      final response = await dataSource.getUserCartProducts();

      // Assert
      expect(response, isA<Error<CartResponseModel>>());

      expect(
        (response as Error<CartResponseModel>).exception.toString(),
        Exception(errorMessage).toString(),
      );
    });
  });

  group("Testing Delete Cart Item", () {
    test("Successfully deleting cart item", () async {
      // Arrange
      when(
        () => mockApiClient.deleteSpecificItem("1"),
      ).thenAnswer(
        (_) async => successCartResponseModel,
      );

      // Act
      final response = await dataSource.deleteSpecificItem("1");

      // Assert
      expect(response, isA<Success<CartResponseModel>>());

      verify(
        () => mockApiClient.deleteSpecificItem("1"),
      ).called(1);
    });

    test("Failed deleting cart item", () async {
      // Arrange
      when(
        () => mockApiClient.deleteSpecificItem("1"),
      ).thenThrow(dioException());

      // Act
      final response = await dataSource.deleteSpecificItem("1");

      // Assert
      expect(response, isA<Error<CartResponseModel>>());

      expect(
        (response as Error<CartResponseModel>).exception.toString(),
        Exception(errorMessage).toString(),
      );
    });
  });

  group("Testing Update Cart Quantity", () {
    test("Successfully updating cart quantity", () async {
      // Arrange
      when(
        () => mockApiClient.updateCartProductQuantity(
          "1",
          {CartValues.quantity: 2},
        ),
      ).thenAnswer(
        (_) async => successCartResponseModel,
      );

      // Act
      final response = await dataSource.updateCartProductQuantity(
        "1",
        2,
      );

      // Assert
      expect(response, isA<Success<CartResponseModel>>());

      verify(
        () => mockApiClient.updateCartProductQuantity(
          "1",
          {CartValues.quantity: 2},
        ),
      ).called(1);
    });

    test("Failed updating cart quantity", () async {
      // Arrange
      when(
        () => mockApiClient.updateCartProductQuantity(
          any(),
          any(),
        ),
      ).thenThrow(dioException());

      // Act
      final response = await dataSource.updateCartProductQuantity(
        "1",
        2,
      );

      // Assert
      expect(response, isA<Error<CartResponseModel>>());

      expect(
        (response as Error<CartResponseModel>).exception.toString(),
        Exception(errorMessage).toString(),
      );
    });
  });

  group("Testing Add To Cart", () {
    test("Successfully adding product to cart", () async {
      // Arrange
      when(
        () => mockApiClient.addToCart(
          {
            CartValues.product: "1",
            CartValues.quantity: 1,
          },
        ),
      ).thenAnswer(
        (_) async => successCartResponseModel,
      );

      // Act
      final response = await dataSource.addToCart(
        "1",
        1,
      );

      // Assert
      expect(response, isA<Success<CartResponseModel>>());

      verify(
        () => mockApiClient.addToCart(
          {
            CartValues.product: "1",
            CartValues.quantity: 1,
          },
        ),
      ).called(1);
    });

    test("Failed adding product to cart", () async {
      // Arrange
      when(
        () => mockApiClient.addToCart(any()),
      ).thenThrow(dioException());

      // Act
      final response = await dataSource.addToCart(
        "1",
        1,
      );

      // Assert
      expect(response, isA<Error<CartResponseModel>>());

      expect(
        (response as Error<CartResponseModel>).exception.toString(),
        Exception(errorMessage).toString(),
      );
    });
  });
}