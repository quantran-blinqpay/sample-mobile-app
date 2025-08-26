import 'package:json_annotation/json_annotation.dart';

part 'watchlist_consignor.g.dart';

@JsonSerializable()
class WatchlistConsignor {
  WatchlistConsignor({
    this.id,
    this.username,
    this.displayName,
  });

  @JsonKey()
  final int? id;
  @JsonKey()
  final String? username;
  @JsonKey(name: "display_name")
  final String? displayName;

  factory WatchlistConsignor.fromJson(Map<String, dynamic> json) =>
      _$WatchlistConsignorFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistConsignorToJson(this);
}
