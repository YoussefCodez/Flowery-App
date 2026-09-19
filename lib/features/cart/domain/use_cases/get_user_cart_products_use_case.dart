import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:flowery/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserCartProductsUseCase {
  final CartRepoContract repo;
  GetUserCartProductsUseCase({required this.repo});

  Future<Result<CartEntity>> call() async {
    return repo.getUserCartProducts();
  }
}
