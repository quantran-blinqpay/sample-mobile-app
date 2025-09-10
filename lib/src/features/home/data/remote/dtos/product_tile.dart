import 'package:qwid/src/features/home/data/remote/dtos/product_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_tile.g.dart';

@JsonSerializable()
class ProductTile {

  @JsonKey()
  final String? id;
  @JsonKey()
  final ProductInfo? values;

  ProductTile({
    this.id,
    this.values,
  });

  factory ProductTile.fromJson(Map<String, dynamic> json) => _$ProductTileFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTileToJson(this);

}