import 'package:equatable/equatable.dart';

import 'best_seller_entity.dart';
import 'category_entity.dart';
import 'occasion_enitity.dart';

class HomeEntity extends Equatable {
  final List<CategoryEntity>? categories;
  final List<BestSellerEntity>? bestSeller;
  final List<OccasionEntity>? occasions;

  const HomeEntity({
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  @override
  List<Object?> get props => [categories, bestSeller, occasions];
}
