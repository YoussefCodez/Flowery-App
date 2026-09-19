import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase {
  final CartRepoContract repo;
  AddToCartUseCase({required this.repo});

  Future<Result<CartEntity>> call(String cartItemId, int quantity) async {
    return repo.addToCart(cartItemId, quantity);
  }
}
