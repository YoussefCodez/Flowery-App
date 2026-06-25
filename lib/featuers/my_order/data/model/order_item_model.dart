import 'package:flowery/featuers/my_order/data/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/order_item_entity.dart';
part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product")
  Product? product;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_id")
  String? id;

  OrderItem({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
  OrderItemEntity toDomain() => OrderItemEntity(
    product: product!.toDomain(),
    price: price??0.0,
    quantity: quantity??0,
    id: id??'',
  );
}