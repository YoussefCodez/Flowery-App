import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/order_entity.dart'; // ✅ added missing import
import 'order_item_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "user")
  String? user;
  @JsonKey(name: "orderItems")
  List<OrderItem>? orderItems;
  @JsonKey(name: "totalPrice")
  int? totalPrice;
  @JsonKey(name: "paymentType")
  String? paymentType;
  @JsonKey(name: "isPaid")
  bool? isPaid;
  @JsonKey(name: "isDelivered")
  bool? isDelivered;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  String? orderNumber;
  @JsonKey(name: "__v")
  int? v;

  Order({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  // ✅ Added missing toDomain()
  OrderEntity toDomain() => OrderEntity(
    id: id ?? '',
    orderNumber: orderNumber ?? '',
    totalPrice: (totalPrice ?? 0).toDouble(), // ✅ int → double
    paymentType: paymentType ?? '',
    isPaid: isPaid ?? false,
    isDelivered: isDelivered ?? false,
    state: state ?? '',
    orderItems: orderItems?.map((item) => item.toDomain()).toList() ?? [],
    createdAt: createdAt ?? DateTime.now(),
  );
}