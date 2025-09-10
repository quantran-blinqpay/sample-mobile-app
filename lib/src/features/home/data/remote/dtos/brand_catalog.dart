import 'package:qwid/src/features/home/data/remote/dtos/brands_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_catalog.g.dart';

@JsonSerializable()
class BrandCatalog {
  final BrandsByCategory? women;
  final BrandsByCategory? men;
  @JsonKey(name: 'beauty-wellness')
  final BrandsByCategory? beautyWellness;
  final BrandsByCategory? home;
  final BrandsByCategory? kids;

  BrandCatalog({
    this.women,
    this.men,
    this.beautyWellness,
    this.home,
    this.kids
  });

  factory BrandCatalog.fromJson(Map<String, dynamic> json) => _$BrandCatalogFromJson(json);

  Map<String, dynamic> toJson() => _$BrandCatalogToJson(this);

}