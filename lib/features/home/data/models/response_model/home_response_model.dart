import 'package:json_annotation/json_annotation.dart';

import 'best_seller_model.dart';
import 'category_model.dart';
import 'occasion_model.dart';
part 'home_response_model.g.dart';

@JsonSerializable()
class HomeResponseModel {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "categories")
  List<Category>? categories;
  @JsonKey(name: "bestSeller")
  List<BestSeller>? bestSeller;
  @JsonKey(name: "occasions")
  List<Occasion>? occasions;

  HomeResponseModel({
    this.message,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) => _$HomeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseModelToJson(this);
}




