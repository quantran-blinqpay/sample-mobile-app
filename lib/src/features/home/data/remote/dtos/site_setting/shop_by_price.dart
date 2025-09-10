import 'package:qwid/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_by_price.g.dart';

@JsonSerializable()
class ShopByPrice {

  ShopByPrice({
    this.name,
    this.id,
    this.isBrand,
    this.isUnder,
    this.price,
  });

  @JsonKey()
  final String? name;
  @JsonKey()
  final int? id;
  @JsonKey(name: "is_brand")
  final int? isBrand;
  @JsonKey(name: "is_under")
  final int? isUnder;
  @JsonKey()
  final int? price;

  factory ShopByPrice.fromJson(Map<String, dynamic> json) => _$ShopByPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ShopByPriceToJson(this);

}