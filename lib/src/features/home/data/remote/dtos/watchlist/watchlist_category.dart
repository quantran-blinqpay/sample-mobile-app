import 'package:json_annotation/json_annotation.dart';

part 'watchlist_category.g.dart';

@JsonSerializable()
class WatchlistCategory {
  WatchlistCategory({
    this.id,
    this.title,
    this.urlTitle,
  });

  @JsonKey()
  final int? id;
  @JsonKey()
  final String? title;
  @JsonKey(name: "url_title")
  final String? urlTitle;

  factory WatchlistCategory.fromJson(Map<String, dynamic> json) =>
      _$WatchlistCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistCategoryToJson(this);
}
