import 'package:json_annotation/json_annotation.dart';

part 'watchlist_amount.g.dart';

@JsonSerializable()
class WatchlistAmount {
  WatchlistAmount({
    this.amount,
    this.currency,
  });

  @JsonKey()
  final int? amount;
  @JsonKey()
  final String? currency;

  factory WatchlistAmount.fromJson(Map<String, dynamic> json) =>
      _$WatchlistAmountFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistAmountToJson(this);
}
