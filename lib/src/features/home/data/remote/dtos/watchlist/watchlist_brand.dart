import 'package:json_annotation/json_annotation.dart';

part 'watchlist_brand.g.dart';

@JsonSerializable()
class WatchlistBrand {
  WatchlistBrand({
    this.id,
    this.title,
    this.urlTitle,
    this.isActive,
  });

  @JsonKey()
  final int? id;
  @JsonKey()
  final String? title;
  @JsonKey(name: "url_title")
  final String? urlTitle;
  @JsonKey(name: "is_active")
  final int? isActive;

  factory WatchlistBrand.fromJson(Map<String, dynamic> json) =>
      _$WatchlistBrandFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistBrandToJson(this);
}
