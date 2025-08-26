import 'package:designerwardrobe/src/features/home/data/remote/dtos/watchlist/watchlist_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watchlist_item.g.dart';

@JsonSerializable()
class WatchlistItem {
  WatchlistItem({
    this.data,
  });

  @JsonKey()
  final List<WatchlistData>? data;

  factory WatchlistItem.fromJson(Map<String, dynamic> json) =>
      _$WatchlistItemFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistItemToJson(this);
}
