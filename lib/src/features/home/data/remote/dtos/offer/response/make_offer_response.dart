import 'package:qwid/src/features/home/data/remote/dtos/brands_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'make_offer_response.g.dart';
@JsonSerializable()
class MakeOfferResponse {
  @JsonKey()
  final MakeOfferData? data;

  MakeOfferResponse({
    this.data,
  });

  factory MakeOfferResponse.fromJson(Map<String, dynamic> json) => _$MakeOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOfferResponseToJson(this);

}

@JsonSerializable()
class MakeOfferData {
  @JsonKey(name: 'id-listing_id')
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'listing_id')
  final int? listingId;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'price_nzd')
  final String? priceNzd;
  @JsonKey(name: 'price_aud')
  final double? priceAud;
  @JsonKey(name: 'seller_display_offer_currency')
  final String? sellerDisplayOfferCurrency;
  @JsonKey(name: 'seller_display_offer_price')
  final int? sellerDisplayOfferPrice;
  @JsonKey(name: 'seller_offer_display_text')
  final String? sellerOfferDisplayText;
  @JsonKey(name: 'buyer_offer_display_text')
  final String? buyerOfferDisplayText;
  @JsonKey(name: 'has_pending_counter_offer')
  final bool? hasPendingCounterOffer;
  @JsonKey(name: 'has_accepted_counter_offer')
  final bool? hasAcceptedCounterOffer;
  @JsonKey(name: 'is_pending')
  final bool? isPending;
  @JsonKey(name: 'is_accepted')
  final bool? isAccepted;
  @JsonKey(name: 'is_declined')
  final bool? isDeclined;
  @JsonKey(name: 'is_expired')
  final bool? isExpired;
  @JsonKey(name: 'created_at')
  final DateTimeObj? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTimeObj? updatedAt;
  @JsonKey(name: 'expires_at')
  final DateTimeObj? expiresAt;

  MakeOfferData({
    this.id,
    this.userId,
    this.listingId,
    this.price,
    this.priceNzd,
    this.priceAud,
    this.sellerDisplayOfferCurrency,
    this.sellerDisplayOfferPrice,
    this.sellerOfferDisplayText,
    this.buyerOfferDisplayText,
    this.hasPendingCounterOffer,
    this.hasAcceptedCounterOffer,
    this.isPending,
    this.isAccepted,
    this.isDeclined,
    this.isExpired,
    this.createdAt,
    this.updatedAt,
    this.expiresAt
  });

  factory MakeOfferData.fromJson(Map<String, dynamic> json) => _$MakeOfferDataFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOfferDataToJson(this);

}

@JsonSerializable()
class DateTimeObj {
  @JsonKey()
  final String? date;

  DateTimeObj({
    this.date,
  });

  factory DateTimeObj.fromJson(Map<String, dynamic> json) => _$DateTimeObjFromJson(json);

  Map<String, dynamic> toJson() => _$DateTimeObjToJson(this);

}

