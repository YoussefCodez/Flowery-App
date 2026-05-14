import 'package:flowery/features/domain/entities/best_seller_product_entity.dart';

sealed class BestSellerStates {}

class BestSellerInitState extends BestSellerStates {}

class BestSellerLoadingState extends BestSellerStates {}

class BestSellerSuccessState extends BestSellerStates {
  final List<BestSellerProductEntity> products;

  BestSellerSuccessState({required this.products});
}

class BestSellerErrorState extends BestSellerStates {}
