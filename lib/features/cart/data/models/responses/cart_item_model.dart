import 'package:flowery/core/const/cart_values.dart';
import 'package:flowery/features/cart/data/models/responses/product_model.dart';
import 'package:flowery/features/cart/domain/entities/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: CartValues.product)
  Product? product;

  @JsonKey(name: CartValues.price)
  int? price;

  @JsonKey(name: CartValues.quantity)
  int? quantity;

  @JsonKey(name: CartValues.id)
  String? id;

  CartItem({this.product, this.price, this.quantity, this.id});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  CartItemEntity toDomain() {
    return CartItemEntity(
      product: product?.toDomain(),
      quantity: quantity,
    );
  }
}
