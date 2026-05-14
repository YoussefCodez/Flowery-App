import 'package:flowery/features/occasions/domain/entities/product_entity.dart';

sealed class OccasionsStates {}

class OccasionsInitState extends OccasionsStates {}

class OccasionsLoadingState extends OccasionsStates {}

class OccasionsSuccessState extends OccasionsStates {
  final List<String>? names;
  final List<String>? ids;
  final List<ProductEntity>? products;
  final int selectedIndex;
  OccasionsSuccessState({
    this.names,
    this.ids,
    this.products,
    this.selectedIndex = 0,
  });

  OccasionsSuccessState copyWith({
    List<String>? names,
    List<String>? ids,
    List<ProductEntity>? products,
    int? selectedIndex,
  }) {
    return OccasionsSuccessState(
      names: names ?? this.names,
      ids: ids ?? this.ids,
      products: products ?? this.products,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class OccasionsFailedState extends OccasionsStates {}
