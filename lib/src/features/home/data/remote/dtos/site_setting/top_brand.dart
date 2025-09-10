import 'package:qwid/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_brand.g.dart';

@JsonSerializable()
class TopBrand {

  TopBrand({
    this.brandTitle,
    this.brandId,
  });

  @JsonKey(name: "brand_title")
  final String? brandTitle;
  @JsonKey(name: "brand_id")
  final int? brandId;

  factory TopBrand.fromJson(Map<String, dynamic> json) => _$TopBrandFromJson(json);

  Map<String, dynamic> toJson() => _$TopBrandToJson(this);

}