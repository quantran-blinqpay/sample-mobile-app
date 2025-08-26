import 'package:json_annotation/json_annotation.dart';

part 'watchlist_condition.g.dart';

@JsonSerializable()
class WatchlistCondition {
  WatchlistCondition({
    this.id,
    this.title,
    this.subTitle,
  });

  @JsonKey()
  final int? id;
  @JsonKey()
  final String? title;
  @JsonKey(name: "sub_title")
  final String? subTitle;

  factory WatchlistCondition.fromJson(Map<String, dynamic> json) =>
      _$WatchlistConditionFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistConditionToJson(this);
}
