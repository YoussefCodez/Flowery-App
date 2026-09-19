import 'package:flowery/core/const/cart_values.dart';
import 'package:flowery/features/cart/data/models/responses/cart_item_model.dart';
import 'package:flowery/features/cart/domain/entities/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: CartValues.id)
  String? id;

  @JsonKey(name: CartValues.user)
  String? user;

  @JsonKey(name: CartValues.cartItems)
  List<CartItem>? cartItems;

  @JsonKey(name: CartValues.appliedCoupons)
  List<dynamic>? appliedCoupons;

  @JsonKey(name: CartValues.discount)
  int? discount;

  @JsonKey(name: CartValues.totalPrice)
  int? totalPrice;

  @JsonKey(name: CartValues.totalPriceAfterDiscount)
  int? totalPriceAfterDiscount;

  @JsonKey(name: CartValues.createdAt)
  DateTime? createdAt;

  @JsonKey(name: CartValues.updatedAt)
  DateTime? updatedAt;

  @JsonKey(name: CartValues.version)
  int? v;

  Cart({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  CartEntity toDomain() {
    return CartEntity(
      numberOfCartItems: cartItems?.length ?? 0,
      discount: discount ?? 0,
      totalPriceAfterDiscount: totalPriceAfterDiscount ?? 0,
      totalPriceBeforeDiscount: totalPrice ?? 0,
      cartItems: cartItems?.map((item) => item.toDomain()).toList() ?? [],
    );
  }
}
