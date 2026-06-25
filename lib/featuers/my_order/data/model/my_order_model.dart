import 'order_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'my_order_model.g.dart';
@JsonSerializable()
class MyOrderResponseModel {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "orders")
  List<Order>? orders;

  MyOrderResponseModel({
    this.message,
    this.orders,
  });

  factory MyOrderResponseModel.fromJson(Map<String, dynamic> json) => _$MyOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderResponseModelToJson(this);
}






