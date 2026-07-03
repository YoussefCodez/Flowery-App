import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/config/error/failures.dart';
import 'package:flowery/features/cart/api/api_client/cart_api_client.dart';
import 'package:flowery/features/cart/api/data_sources/cart_remote_data_source_impl.dart';
import 'package:flowery/features/cart/data/models/requests/cart_request_model.dart';
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

  const errorMessage = "Something went wrong";

  final cartItem1 = CartItem(
    id: "1",
    price: 110,
    product: Product(),
    quantity: 1,
  );

  final cartItem2 = CartItem(
    id: "2",
    price: 110,
    product: Product(),
    quantity: 2,
  );

  final cartItems = [cartItem1, cartItem2];

  final successCartResponseModel = CartResponseModel(
    message: "success",
    cart: Cart(cartItems: cartItems),
    numOfCartItems: cartItems.length,
  );

  setUp(() {
    mockApiClient = MockCartApiClient();
    dataSource = CartRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  DioException dioException() {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {"message": errorMessage},
      ),
    );
  }

  group("Testing Get User Cart", () {
    test("Successfully getting cart", () async {
      when(
        () => mockApiClient.getUserCartProducts(),
      ).thenAnswer((_) async => successCartResponseModel);

      final response = await dataSource.getUserCartProducts();

      expect(response, isA<Success<CartResponseModel>>());

      verify(() => mockApiClient.getUserCartProducts()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test("Failed getting cart", () async {
      when(() => mockApiClient.getUserCartProducts()).thenThrow(dioException());

      final response = await dataSource.getUserCartProducts();

      expect(response, isA<Error<CartResponseModel>>());

      verify(() => mockApiClient.getUserCartProducts()).called(1);

      expect(
        (response as Error<CartResponseModel>).exception,
        isA<ServerFailure>(),
      );

      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("Testing Delete Cart Item", () {
    test("Successfully deleting cart item", () async {
      when(
        () => mockApiClient.deleteSpecificItem("1"),
      ).thenAnswer((_) async => successCartResponseModel);

      final response = await dataSource.deleteSpecificItem("1");

      expect(response, isA<Success<CartResponseModel>>());

      verify(() => mockApiClient.deleteSpecificItem("1")).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test("Failed deleting cart item", () async {
      when(
        () => mockApiClient.deleteSpecificItem("1"),
      ).thenThrow(dioException());

      final response = await dataSource.deleteSpecificItem("1");

      expect(response, isA<Error<CartResponseModel>>());

      verify(() => mockApiClient.deleteSpecificItem("1")).called(1);

      expect(
        (response as Error<CartResponseModel>).exception,
        isA<ServerFailure>(),
      );

      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("Testing Update Cart Quantity", () {
    test("Successfully updating cart quantity", () async {
      when(
        () => mockApiClient.updateCartProductQuantity(any(), any()),
      ).thenAnswer((_) async => successCartResponseModel);

      final response = await dataSource.updateCartProductQuantity("1", 2);

      expect(response, isA<Success<CartResponseModel>>());

      final captured = verify(
        () =>
            mockApiClient.updateCartProductQuantity(captureAny(), captureAny()),
      ).captured;

      expect(captured[0], "1");

      final request = captured[1] as CartRequestModel;
      expect(request.productId, isNull);
      expect(request.quantity, 2);

      verifyNoMoreInteractions(mockApiClient);
    });

    test("Failed updating cart quantity", () async {
      when(
        () => mockApiClient.updateCartProductQuantity(any(), any()),
      ).thenThrow(dioException());

      final response = await dataSource.updateCartProductQuantity("1", 2);

      expect(response, isA<Error<CartResponseModel>>());

      final captured = verify(
        () =>
            mockApiClient.updateCartProductQuantity(captureAny(), captureAny()),
      ).captured;

      expect(captured[0], "1");

      final request = captured[1] as CartRequestModel;
      expect(request.productId, isNull);
      expect(request.quantity, 2);

      expect(
        (response as Error<CartResponseModel>).exception,
        isA<ServerFailure>(),
      );

      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("Testing Add To Cart", () {
    test("Successfully adding product to cart", () async {
      when(
        () => mockApiClient.addToCart(any()),
      ).thenAnswer((_) async => successCartResponseModel);

      final response = await dataSource.addToCart("1", 1);

      expect(response, isA<Success<CartResponseModel>>());

      final request =
          verify(() => mockApiClient.addToCart(captureAny())).captured.single
              as CartRequestModel;

      expect(request.productId, "1");
      expect(request.quantity, 1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test("Failed adding product to cart", () async {
      when(() => mockApiClient.addToCart(any())).thenThrow(dioException());

      final response = await dataSource.addToCart("1", 1);

      expect(response, isA<Error<CartResponseModel>>());

      final request =
          verify(() => mockApiClient.addToCart(captureAny())).captured.single
              as CartRequestModel;

      expect(request.productId, "1");
      expect(request.quantity, 1);

      expect(
        (response as Error<CartResponseModel>).exception,
        isA<ServerFailure>(),
      );

      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
