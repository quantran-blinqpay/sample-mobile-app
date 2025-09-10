import 'package:qwid/src/features/home/data/remote/dtos/brands_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'counter_offer_parameter.g.dart';

@JsonSerializable()
class CounterOfferParameter {
  @JsonKey(name: 'listing_id')
  final int? listingId;
  @JsonKey(name: 'listing_offer_id')
  final int? listingOfferId;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'excludes_shipping_forwarding')
  final int? excludesShippingForwarding;

  CounterOfferParameter({
    this.listingId,
    this.listingOfferId,
    this.price,
    this.currency,
    this.excludesShippingForwarding,
  });

  factory CounterOfferParameter.fromJson(Map<String, dynamic> json) => _$CounterOfferParameterFromJson(json);

  Map<String, dynamic> toJson() => _$CounterOfferParameterToJson(this);

}