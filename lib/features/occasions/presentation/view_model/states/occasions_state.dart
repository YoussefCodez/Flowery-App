import 'package:equatable/equatable.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

@immutable
class OccasionsState extends Equatable {
  final bool isLoadingOccasions;
  final bool isLoadingProducts;

  final List<String> names;
  final List<String> ids;
  final List<ProductEntity> products;

  final int selectedIndex;

  final String? errorMessage;

  const OccasionsState({
    this.isLoadingOccasions = false,
    this.isLoadingProducts = false,
    this.names = const [],
    this.ids = const [],
    this.products = const [],
    this.selectedIndex = 0,
    this.errorMessage,
  });

  OccasionsState copyWith({
    bool? isLoadingOccasions,
    bool? isLoadingProducts,
    List<String>? names,
    List<String>? ids,
    List<ProductEntity>? products,
    int? selectedIndex,
    String? errorMessage,
  }) {
    return OccasionsState(
      isLoadingOccasions:
          isLoadingOccasions ?? this.isLoadingOccasions,

      isLoadingProducts:
          isLoadingProducts ?? this.isLoadingProducts,

      names: names ?? this.names,
      ids: ids ?? this.ids,
      products: products ?? this.products,

      selectedIndex:
          selectedIndex ?? this.selectedIndex,

      errorMessage:
          errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoadingOccasions,
        isLoadingProducts,
        names,
        ids,
        products,
        selectedIndex,
        errorMessage,
      ];
}