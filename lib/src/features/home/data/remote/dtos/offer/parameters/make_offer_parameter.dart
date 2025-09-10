import 'package:qwid/src/features/home/data/remote/dtos/brands_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'make_offer_parameter.g.dart';

@JsonSerializable()
class MakeOfferParameter {
  @JsonKey(name: 'listing_id')
  final int? listingId;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'currency')
  final String? currency;

  MakeOfferParameter({
    this.listingId,
    this.price,
    this.currency,
  });

  factory MakeOfferParameter.fromJson(Map<String, dynamic> json) => _$MakeOfferParameterFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOfferParameterToJson(this);

}