import 'package:json_annotation/json_annotation.dart';

part 'brand_item.g.dart';

@JsonSerializable()
class BrandItem {
  final int? id;
  final String? title;
  @JsonKey(name: 'url_title')
  final String? urlTitle;
  final String? description;
  final int? isTopRental;
  final int? isTopSale;
  final int? popularityScore;

  BrandItem({
    this.id,
    this.title,
    this.urlTitle,
    this.description,
    this.isTopRental,
    this.isTopSale,
    this.popularityScore,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) =>
      _$BrandItemFromJson(json);

  Map<String, dynamic> toJson() => _$BrandItemToJson(this);
}
