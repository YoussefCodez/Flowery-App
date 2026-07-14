import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSpecificCartItemUseCase {
  final CartRepoContract repo;
  DeleteSpecificCartItemUseCase({required this.repo});

  Future<Result<CartEntity>> call(String cartItemId) async {
    return repo.deleteSpecificItem(cartItemId);
  }
}
