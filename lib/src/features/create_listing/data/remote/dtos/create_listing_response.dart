// To parse this JSON data, do
//
//     final createListingResponse = createListingResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_listing_response.g.dart';

CreateListingResponse createListingResponseFromJson(String str) =>
    CreateListingResponse.fromJson(json.decode(str));

String createListingResponseToJson(CreateListingResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CreateListingResponse {
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "status_code")
  int? statusCode;
  @JsonKey(name: "success")
  bool? success;

  CreateListingResponse({
    this.data,
    this.statusCode,
    this.success,
  });

  factory CreateListingResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateListingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateListingResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "barcode_number")
  int? barcodeNumber;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "brand")
  Brand? brand;
  @JsonKey(name: "category")
  Brand? category;
  @JsonKey(name: "condition")
  Condition? condition;
  @JsonKey(name: "colour")
  String? colour;
  @JsonKey(name: "size_fit_text")
  dynamic sizeFitText;
  @JsonKey(name: "price_nzd")
  double? priceNzd;
  @JsonKey(name: "price_nzd_minus_shipping")
  double? priceNzdMinusShipping;
  @JsonKey(name: "price_aud")
  int? priceAud;
  @JsonKey(name: "price_aud_minus_shipping")
  int? priceAudMinusShipping;
  @JsonKey(name: "original_currency")
  String? originalCurrency;
  @JsonKey(name: "price_retail_nzd")
  int? priceRetailNzd;
  @JsonKey(name: "price_retail_aud")
  int? priceRetailAud;
  @JsonKey(name: "retail_saving_percent")
  String? retailSavingPercent;
  @JsonKey(name: "retail_saving_percent_nz")
  String? retailSavingPercentNz;
  @JsonKey(name: "retail_saving_percent_au")
  String? retailSavingPercentAu;
  @JsonKey(name: "price_original_nzd")
  double? priceOriginalNzd;
  @JsonKey(name: "price_original_aud")
  int? priceOriginalAud;
  @JsonKey(name: "price_shipping_au_to_au_aud")
  int? priceShippingAuToAuAud;
  @JsonKey(name: "price_shipping_au_to_nz_aud")
  int? priceShippingAuToNzAud;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_available")
  bool? isAvailable;
  @JsonKey(name: "is_rental")
  bool? isRental;
  @JsonKey(name: "is_dw_rental")
  bool? isDwRental;
  @JsonKey(name: "is_dw_clearance")
  bool? isDwClearance;
  @JsonKey(name: "is_wanted")
  bool? isWanted;
  @JsonKey(name: "is_featured")
  bool? isFeatured;
  @JsonKey(name: "is_valet")
  bool? isValet;
  @JsonKey(name: "is_vintage")
  bool? isVintage;
  @JsonKey(name: "is_sold")
  bool? isSold;
  @JsonKey(name: "is_safe_to_delete")
  bool? isSafeToDelete;
  @JsonKey(name: "is_expired")
  bool? isExpired;
  @JsonKey(name: "is_reduced")
  bool? isReduced;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "is_draft")
  bool? isDraft;
  @JsonKey(name: "is_blacklisted")
  bool? isBlacklisted;
  @JsonKey(name: "is_hot")
  bool? isHot;
  @JsonKey(name: "is_watchlist_notification_disable")
  bool? isWatchlistNotificationDisable;
  @JsonKey(name: "display_watchlist_heart")
  bool? displayWatchlistHeart;
  @JsonKey(name: "is_in_watchlist")
  bool? isInWatchlist;
  @JsonKey(name: "number_of_watchers")
  int? numberOfWatchers;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "owner_deleted")
  bool? ownerDeleted;
  @JsonKey(name: "valet_status")
  dynamic valetStatus;
  @JsonKey(name: "has_stock")
  bool? hasStock;
  @JsonKey(name: "stock_count")
  int? stockCount;
  @JsonKey(name: "listing_bumps")
  List<dynamic>? listingBumps;
  @JsonKey(name: "views")
  int? views;
  @JsonKey(name: "sold_to")
  int? soldTo;
  @JsonKey(name: "is_highlighted")
  bool? isHighlighted;
  @JsonKey(name: "item_fit")
  dynamic itemFit;
  @JsonKey(name: "cleaning_type")
  dynamic cleaningType;
  @JsonKey(name: "rental_status")
  dynamic rentalStatus;
  @JsonKey(name: "home_dwr_store_id")
  int? homeDwrStoreId;
  @JsonKey(name: "current_dwr_store_id")
  int? currentDwrStoreId;
  @JsonKey(name: "next_rental_slot")
  List<dynamic>? nextRentalSlot;
  @JsonKey(name: "current_rental_slot")
  List<dynamic>? currentRentalSlot;
  @JsonKey(name: "is_essential_listing")
  bool? isEssentialListing;
  @JsonKey(name: "has_shipping_kit")
  bool? hasShippingKit;
  @JsonKey(name: "display_book_a_courier_pickup")
  bool? displayBookACourierPickup;
  @JsonKey(name: "is_consignment")
  bool? isConsignment;
  @JsonKey(name: "in_subs_pool")
  bool? inSubsPool;
  @JsonKey(name: "consignor_user_id")
  int? consignorUserId;
  @JsonKey(name: "consignor")
  Consignor? consignor;
  @JsonKey(name: "recycle_consignor_id")
  int? recycleConsignorId;
  @JsonKey(name: "has_tie")
  bool? hasTie;
  @JsonKey(name: "can_ship_to_nz")
  bool? canShipToNz;
  @JsonKey(name: "can_ship_to_au")
  bool? canShipToAu;
  @JsonKey(name: "price_pattern")
  PricePattern? pricePattern;
  @JsonKey(name: "show_afterpay")
  bool? showAfterpay;
  @JsonKey(name: "show_laybuy")
  bool? showLaybuy;
  @JsonKey(name: "show_zip")
  bool? showZip;
  @JsonKey(name: "enable_buy_now_pay_later")
  bool? enableBuyNowPayLater;

  Data({
    this.id,
    this.barcodeNumber,
    this.userId,
    this.title,
    this.urlTitle,
    this.brand,
    this.category,
    this.condition,
    this.colour,
    this.sizeFitText,
    this.priceNzd,
    this.priceNzdMinusShipping,
    this.priceAud,
    this.priceAudMinusShipping,
    this.originalCurrency,
    this.priceRetailNzd,
    this.priceRetailAud,
    this.retailSavingPercent,
    this.retailSavingPercentNz,
    this.retailSavingPercentAu,
    this.priceOriginalNzd,
    this.priceOriginalAud,
    this.priceShippingAuToAuAud,
    this.priceShippingAuToNzAud,
    this.description,
    this.isAvailable,
    this.isRental,
    this.isDwRental,
    this.isDwClearance,
    this.isWanted,
    this.isFeatured,
    this.isValet,
    this.isVintage,
    this.isSold,
    this.isSafeToDelete,
    this.isExpired,
    this.isReduced,
    this.isActive,
    this.isDraft,
    this.isBlacklisted,
    this.isHot,
    this.isWatchlistNotificationDisable,
    this.displayWatchlistHeart,
    this.isInWatchlist,
    this.numberOfWatchers,
    this.url,
    this.ownerDeleted,
    this.valetStatus,
    this.hasStock,
    this.stockCount,
    this.listingBumps,
    this.views,
    this.soldTo,
    this.isHighlighted,
    this.itemFit,
    this.cleaningType,
    this.rentalStatus,
    this.homeDwrStoreId,
    this.currentDwrStoreId,
    this.nextRentalSlot,
    this.currentRentalSlot,
    this.isEssentialListing,
    this.hasShippingKit,
    this.displayBookACourierPickup,
    this.isConsignment,
    this.inSubsPool,
    this.consignorUserId,
    this.consignor,
    this.recycleConsignorId,
    this.hasTie,
    this.canShipToNz,
    this.canShipToAu,
    this.pricePattern,
    this.showAfterpay,
    this.showLaybuy,
    this.showZip,
    this.enableBuyNowPayLater,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Brand {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "is_active")
  int? isActive;

  Brand({
    this.id,
    this.title,
    this.urlTitle,
    this.isActive,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class Condition {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "sub_title")
  String? subTitle;

  Condition({
    this.id,
    this.title,
    this.subTitle,
  });

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

@JsonSerializable()
class Consignor {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "username")
  dynamic username;
  @JsonKey(name: "display_name")
  dynamic displayName;

  Consignor({
    this.id,
    this.username,
    this.displayName,
  });

  factory Consignor.fromJson(Map<String, dynamic> json) =>
      _$ConsignorFromJson(json);

  Map<String, dynamic> toJson() => _$ConsignorToJson(this);
}

@JsonSerializable()
class PricePattern {
  @JsonKey(name: "currency")
  String? currency;
  @JsonKey(name: "sale_price_without_shipping_fee")
  int? salePriceWithoutShippingFee;
  @JsonKey(name: "original_price")
  int? originalPrice;
  @JsonKey(name: "shipping_to_nz")
  ShippingTo? shippingToNz;
  @JsonKey(name: "shipping_to_au")
  ShippingTo? shippingToAu;

  PricePattern({
    this.currency,
    this.salePriceWithoutShippingFee,
    this.originalPrice,
    this.shippingToNz,
    this.shippingToAu,
  });

  factory PricePattern.fromJson(Map<String, dynamic> json) =>
      _$PricePatternFromJson(json);

  Map<String, dynamic> toJson() => _$PricePatternToJson(this);
}

@JsonSerializable()
class ShippingTo {
  @JsonKey(name: "amount")
  int? amount;
  @JsonKey(name: "currency")
  String? currency;

  ShippingTo({
    this.amount,
    this.currency,
  });

  factory ShippingTo.fromJson(Map<String, dynamic> json) =>
      _$ShippingToFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingToToJson(this);
}
