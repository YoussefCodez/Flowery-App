import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateSpecificCartItemQuantityUseCase {
  final CartRepoContract repo;
  UpdateSpecificCartItemQuantityUseCase({required this.repo});

  Future<Result<CartEntity>> call(String cartItemId, int quantity) async {
    return repo.updateCartProductQuantity(cartItemId, quantity);
  }
}
