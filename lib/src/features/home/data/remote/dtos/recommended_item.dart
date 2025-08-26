import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommended_item.g.dart';

@JsonSerializable()
class RecommendedItems {

  RecommendedItems({
    this.recommId,
    this.numberNextRecommsCalls,
    this.recomms,
  });

  @JsonKey()
  final String? recommId;
  @JsonKey()
  final int? numberNextRecommsCalls;
  @JsonKey()
  final List<ProductTile>? recomms;

  factory RecommendedItems.fromJson(Map<String, dynamic> json) => _$RecommendedItemsFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedItemsToJson(this);

}