import 'package:designerwardrobe/src/features/home/data/remote/dtos/watchlist/watchlist_amount.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watchlist_price_pattern.g.dart';

@JsonSerializable()
class WatchlistPricePattern {
  WatchlistPricePattern({
    this.currency,
    this.salePriceWithoutShippingFee,
    this.originalPrice,
    this.shippingToNz,
    this.shippingToAu,
  });

  @JsonKey()
  final String? currency;
  @JsonKey(name: "sale_price_without_shipping_fee")
  final int? salePriceWithoutShippingFee;
  @JsonKey(name: "original_price")
  final int? originalPrice;
  @JsonKey(name: "shipping_to_nz")
  final WatchlistAmount? shippingToNz;
  @JsonKey(name: "shipping_to_au")
  final WatchlistAmount? shippingToAu;

  factory WatchlistPricePattern.fromJson(Map<String, dynamic> json) =>
      _$WatchlistPricePatternFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistPricePatternToJson(this);
}
