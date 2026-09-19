import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flowery/features/cart/data/models/responses/cart_item_model.dart';
import 'package:flowery/features/cart/data/models/responses/cart_model.dart';
import 'package:flowery/features/cart/data/models/responses/cart_response_model.dart';
import 'package:flowery/features/cart/data/models/responses/product_model.dart';
import 'package:flowery/features/cart/data/repo/cart_repo_impl.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartRemoteDataSourceContract extends Mock
    implements CartRemoteDataSourceContract {}

void main() {
  late CartRepoImpl repo;
  late MockCartRemoteDataSourceContract remote;

  const errorMessage = "An error has occurred";

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
    remote = MockCartRemoteDataSourceContract();
    repo = CartRepoImpl(remoteDataSource: remote);
  });

  group("Get User Cart", () {
    test("Success", () async {
      when(() => remote.getUserCartProducts()).thenAnswer(
        (_) async => Success<CartResponseModel>(
          data: successCartResponseModel,
        ),
      );

      final result = await repo.getUserCartProducts();

      verify(() => remote.getUserCartProducts()).called(1);

      expect(result, isA<Success<CartEntity>>());

      final cart = (result as Success<CartEntity>).data;

      expect(cart, isNotNull);
      expect(cart!.cartItems, isNotEmpty);

      verifyNoMoreInteractions(remote);
    });

    test("Failure", () async {
      when(() => remote.getUserCartProducts()).thenAnswer(
        (_) async => Error<CartResponseModel>(
          exception: Exception(errorMessage),
        ),
      );

      final result = await repo.getUserCartProducts();

      verify(() => remote.getUserCartProducts()).called(1);

      expect(result, isA<Error<CartEntity>>());

      expect(
        (result as Error<CartEntity>).exception.toString(),
        Exception(errorMessage).toString(),
      );

      verifyNoMoreInteractions(remote);
    });
  });

  group("Delete Cart Item", () {
    test("Success", () async {
      when(() => remote.deleteSpecificItem("1")).thenAnswer(
        (_) async => Success<CartResponseModel>(
          data: successCartResponseModel,
        ),
      );

      final result = await repo.deleteSpecificItem("1");

      verify(() => remote.deleteSpecificItem("1")).called(1);

      expect(result, isA<Success<CartEntity>>());

      final cart = (result as Success<CartEntity>).data;
      expect(cart, isNotNull);

      verifyNoMoreInteractions(remote);
    });

    test("Failure", () async {
      when(() => remote.deleteSpecificItem("1")).thenAnswer(
        (_) async => Error<CartResponseModel>(
          exception: Exception(errorMessage),
        ),
      );

      final result = await repo.deleteSpecificItem("1");

      verify(() => remote.deleteSpecificItem("1")).called(1);

      expect(result, isA<Error<CartEntity>>());

      verifyNoMoreInteractions(remote);
    });
  });

  group("Update Quantity", () {
    test("Success", () async {
      when(() => remote.updateCartProductQuantity("1", 2)).thenAnswer(
        (_) async => Success<CartResponseModel>(
          data: successCartResponseModel,
        ),
      );

      final result = await repo.updateCartProductQuantity("1", 2);

      verify(() => remote.updateCartProductQuantity("1", 2)).called(1);

      expect(result, isA<Success<CartEntity>>());

      verifyNoMoreInteractions(remote);
    });

    test("Failure", () async {
      when(() => remote.updateCartProductQuantity("1", 2)).thenAnswer(
        (_) async => Error<CartResponseModel>(
          exception: Exception(errorMessage),
        ),
      );

      final result = await repo.updateCartProductQuantity("1", 2);

      verify(() => remote.updateCartProductQuantity("1", 2)).called(1);

      expect(result, isA<Error<CartEntity>>());

      verifyNoMoreInteractions(remote);
    });
  });

  group("Add To Cart", () {
    test("Success", () async {
      when(() => remote.addToCart("1", 1)).thenAnswer(
        (_) async => Success<CartResponseModel>(
          data: successCartResponseModel,
        ),
      );

      final result = await repo.addToCart("1", 1);

      verify(() => remote.addToCart("1", 1)).called(1);

      expect(result, isA<Success<CartEntity>>());

      verifyNoMoreInteractions(remote);
    });

    test("Failure", () async {
      when(() => remote.addToCart("1", 1)).thenAnswer(
        (_) async => Error<CartResponseModel>(
          exception: Exception(errorMessage),
        ),
      );

      final result = await repo.addToCart("1", 1);

      verify(() => remote.addToCart("1", 1)).called(1);

      expect(result, isA<Error<CartEntity>>());

      verifyNoMoreInteractions(remote);
    });
  });
}