import 'package:qwid/src/features/home/data/remote/dtos/watchlist/watchlist_brand.dart';
import 'package:qwid/src/features/home/data/remote/dtos/watchlist/watchlist_category.dart';
import 'package:qwid/src/features/home/data/remote/dtos/watchlist/watchlist_condition.dart';
import 'package:qwid/src/features/home/data/remote/dtos/watchlist/watchlist_consignor.dart';
import 'package:qwid/src/features/home/data/remote/dtos/watchlist/watchlist_price_pattern.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watchlist_data.g.dart';

@JsonSerializable()
class WatchlistData {
  WatchlistData({
    this.id,
    this.barcode_number,
    this.user_id,
    this.title,
    this.url_title,
    this.brand,
    this.category,
    this.condition,
    this.colour,
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
    this.hasStock,
    this.stockCount,
    this.views,
    this.soldTo,
    this.isHighlighted,
    this.homeDwrStoreId,
    this.currentDwrStoreId,
    this.isEssentialListing,
    this.hasShippingLit,
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

  @JsonKey()
  final int? id;
  @JsonKey(name: "barcode_number")
  final int? barcode_number;
  @JsonKey(name: "user_id")
  final int? user_id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "url_title")
  final String? url_title;
  @JsonKey()
  final WatchlistBrand? brand;
  @JsonKey()
  final WatchlistCategory? category;
  @JsonKey()
  final WatchlistCondition? condition;
  @JsonKey()
  final String? colour;
  @JsonKey(name: "price_nzd")
  final int? priceNzd;
  @JsonKey(name: "price_nzd_minus_shipping")
  final int? priceNzdMinusShipping;
  @JsonKey(name: "price_aud")
  final double? priceAud;
  @JsonKey(name: "price_aud_minus_shipping")
  final double? priceAudMinusShipping;
  @JsonKey(name: "original_currency")
  final String? originalCurrency;
  @JsonKey(name: "price_retail_nzd")
  final int? priceRetailNzd;
  @JsonKey(name: "price_retail_aud")
  final double? priceRetailAud;
  @JsonKey(name: "retail_saving_percent")
  final String? retailSavingPercent;
  @JsonKey(name: "retail_saving_percent_nz")
  final String? retailSavingPercentNz;
  @JsonKey(name: "retail_saving_percent_au")
  final String? retailSavingPercentAu;
  @JsonKey(name: "price_original_nzd")
  final int? priceOriginalNzd;
  @JsonKey(name: "price_original_aud")
  final double? priceOriginalAud;
  @JsonKey(name: "price_shipping_au_to_au_aud")
  final int? priceShippingAuToAuAud;
  @JsonKey(name: "price_shipping_au_to_nz_aud")
  final int? priceShippingAuToNzAud;
  @JsonKey()
  final String? description;
  @JsonKey(name: "is_available")
  final bool? isAvailable;
  @JsonKey(name: "is_rental")
  final bool? isRental;
  @JsonKey(name: "is_dw_rental")
  final bool? isDwRental;
  @JsonKey(name: "is_dw_clearance")
  final bool? isDwClearance;
  @JsonKey(name: "is_wanted")
  final bool? isWanted;
  @JsonKey(name: "is_featured")
  final bool? isFeatured;
  @JsonKey(name: "is_valet")
  final bool? isValet;
  @JsonKey(name: "is_vintage")
  final bool? isVintage;
  @JsonKey(name: "is_sold")
  final bool? isSold;
  @JsonKey(name: "is_safe_to_delete")
  final bool? isSafeToDelete;
  @JsonKey(name: "is_expired")
  final bool? isExpired;
  @JsonKey(name: "is_reduced")
  final bool? isReduced;
  @JsonKey(name: "is_active")
  final bool? isActive;
  @JsonKey(name: "is_draft")
  final bool? isDraft;
  @JsonKey(name: "is_blacklisted")
  final bool? isBlacklisted;
  @JsonKey(name: "is_hot")
  final bool? isHot;
  @JsonKey(name: "is_watchlist_notification_disable")
  final bool? isWatchlistNotificationDisable;
  @JsonKey(name: "display_watchlist_heart")
  final bool? displayWatchlistHeart;
  @JsonKey(name: "is_in_watchlist")
  final bool? isInWatchlist;
  @JsonKey(name: "number_of_watchers")
  final int? numberOfWatchers;
  @JsonKey()
  final String? url;
  @JsonKey(name: "owner_deleted")
  final bool? ownerDeleted;
  @JsonKey(name: "has_stock")
  final bool? hasStock;
  @JsonKey(name: "stock_count")
  final int? stockCount;
  @JsonKey(name: "views")
  final int? views;
  @JsonKey(name: "sold_to")
  final int? soldTo;
  @JsonKey(name: "is_highlighted")
  final bool? isHighlighted;
  @JsonKey(name: "home_dwr_store_id")
  final int? homeDwrStoreId;
  @JsonKey(name: "current_dwr_store_id")
  final int? currentDwrStoreId;
  @JsonKey(name: "is_essential_listing")
  final bool? isEssentialListing;
  @JsonKey(name: "has_shipping_kit")
  final bool? hasShippingLit;
  @JsonKey(name: "display_book_a_courier_pickup")
  final bool? displayBookACourierPickup;
  @JsonKey(name: "is_consignment")
  final bool? isConsignment;
  @JsonKey(name: "in_subs_pool")
  final bool? inSubsPool;
  @JsonKey(name: "consignor_user_id")
  final int? consignorUserId;
  @JsonKey()
  final WatchlistConsignor? consignor;
  @JsonKey(name: "recycle_consignor_id")
  final int? recycleConsignorId;
  @JsonKey(name: "has_tie")
  final bool? hasTie;
  @JsonKey(name: "can_ship_to_nz")
  final bool? canShipToNz;
  @JsonKey(name: "can_ship_to_au")
  final bool? canShipToAu;
  @JsonKey(name: "price_pattern")
  final WatchlistPricePattern? pricePattern;
  @JsonKey(name: "show_afterpay")
  final bool? showAfterpay;
  @JsonKey(name: "show_laybuy")
  final bool? showLaybuy;
  @JsonKey(name: "show_zip")
  final bool? showZip;
  @JsonKey(name: "enable_buy_now_pay_later")
  final bool? enableBuyNowPayLater;

  factory WatchlistData.fromJson(Map<String, dynamic> json) =>
      _$WatchlistDataFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistDataToJson(this);
}
