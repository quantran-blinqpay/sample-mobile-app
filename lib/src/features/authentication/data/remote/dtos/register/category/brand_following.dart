import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/category_size.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_following.g.dart';

// "id": 1089462,
// "frequency": "daily",
// "has_new_items": false,
//  "brands": {
//   "2181": "Glassons"
//  },
//  "shop_link": "https:\/\/sandbox.designerwardrobe.co.nz\/shop?brand=glassons"
@JsonSerializable()
class BrandFollowing {
  @JsonKey()
  final int? id;
  @JsonKey()
  final String? frequency;
  @JsonKey(name: 'has_new_items')
  final bool? hasNewItems;
  @JsonKey(name: 'shop_link')
  final String? shopLink;

  BrandFollowing({this.id, this.frequency, this.hasNewItems, this.shopLink});

  factory BrandFollowing.fromJson(Map<String, dynamic> json) =>
      _$BrandFollowingFromJson(json);

  Map<String, dynamic> toJson() => _$BrandFollowingToJson(this);
}