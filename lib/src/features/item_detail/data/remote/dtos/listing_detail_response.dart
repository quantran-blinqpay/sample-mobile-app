// To parse this JSON data, do
//
//     final listingDetailResponse = listingDetailResponseFromJson(jsonString);

import 'package:qwid/src/features/filter/data/remote/dtos/filter_hits_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'listing_detail_response.g.dart';

ListingDetailResponse listingDetailResponseFromJson(String str) =>
    ListingDetailResponse.fromJson(json.decode(str));

String listingDetailResponseToJson(ListingDetailResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ListingDetailResponse {
  @JsonKey(name: "data")
  ListingDetailResponseData? data;

  ListingDetailResponse({
    this.data,
  });

  factory ListingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ListingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListingDetailResponseToJson(this);
}

@JsonSerializable()
class ListingDetailResponseData {
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
  int? priceNzd;
  @JsonKey(name: "price_nzd_minus_shipping")
  int? priceNzdMinusShipping;
  @JsonKey(name: "price_aud")
  double? priceAud;
  @JsonKey(name: "price_aud_minus_shipping")
  double? priceAudMinusShipping;
  @JsonKey(name: "original_currency")
  String? originalCurrency;
  @JsonKey(name: "price_retail_nzd")
  int? priceRetailNzd;
  @JsonKey(name: "price_retail_aud")
  double? priceRetailAud;
  @JsonKey(name: "retail_saving_percent")
  String? retailSavingPercent;
  @JsonKey(name: "retail_saving_percent_nz")
  String? retailSavingPercentNz;
  @JsonKey(name: "retail_saving_percent_au")
  String? retailSavingPercentAu;
  @JsonKey(name: "price_original_nzd")
  int? priceOriginalNzd;
  @JsonKey(name: "price_original_aud")
  double? priceOriginalAud;
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
  List<ListingBump>? listingBumps;
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
  @JsonKey(name: "PrimaryImage")
  PrimaryImage? primaryImage;
  @JsonKey(name: "SecondaryImages")
  SecondaryImages? secondaryImages;
  @JsonKey(name: "User")
  User? user;
  @JsonKey(name: "Detail")
  Detail? detail;
  @JsonKey(name: "Counts")
  PurpleCounts? counts;
  @JsonKey(name: "Sizes")
  Sizes? sizes;
  @JsonKey(name: "Stock")
  SecondaryImages? stock;
  @JsonKey(name: "Tags")
  SecondaryImages? tags;

  ListingDetailResponseData({
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
    this.primaryImage,
    this.secondaryImages,
    this.user,
    this.detail,
    this.counts,
    this.sizes,
    this.stock,
    this.tags,
  });

  factory ListingDetailResponseData.fromJson(Map<String, dynamic> json) =>
      _$ListingDetailResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListingDetailResponseDataToJson(this);

  List<Dat> getCarouselListImage() {
    final List<Dat> primary =
        primaryImage?.data != null ? [primaryImage!.data!] : [];

    final List<Dat> secondary = secondaryImages?.data?.isNotEmpty ?? false
        ? secondaryImages!.data!
        : [];

    return [...primary, ...secondary];
  }
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
class PurpleCounts {
  @JsonKey(name: "data")
  PurpleData? data;

  PurpleCounts({
    this.data,
  });

  factory PurpleCounts.fromJson(Map<String, dynamic> json) =>
      _$PurpleCountsFromJson(json);

  Map<String, dynamic> toJson() => _$PurpleCountsToJson(this);
}

@JsonSerializable()
class PurpleData {
  @JsonKey(name: "question_count")
  int? questionCount;
  @JsonKey(name: "unanswered_question_count")
  int? unansweredQuestionCount;
  @JsonKey(name: "offer_count")
  int? offerCount;
  @JsonKey(name: "pending_offer_count")
  int? pendingOfferCount;
  @JsonKey(name: "rental_booking_count")
  int? rentalBookingCount;

  PurpleData({
    this.questionCount,
    this.unansweredQuestionCount,
    this.offerCount,
    this.pendingOfferCount,
    this.rentalBookingCount,
  });

  factory PurpleData.fromJson(Map<String, dynamic> json) =>
      _$PurpleDataFromJson(json);

  Map<String, dynamic> toJson() => _$PurpleDataToJson(this);
}

@JsonSerializable()
class Detail {
  @JsonKey(name: "data")
  DetailData? data;

  Detail({
    this.data,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}

@JsonSerializable()
class DetailData {
  @JsonKey(name: "shipping_cost")
  int? shippingCost;
  @JsonKey(name: "sold_to")
  int? soldTo;
  @JsonKey(name: "sold_at")
  dynamic soldAt;
  @JsonKey(name: "sold_price")
  int? soldPrice;
  @JsonKey(name: "sold_price_currency")
  dynamic soldPriceCurrency;
  @JsonKey(name: "sellers_display_sold_currency")
  String? sellersDisplaySoldCurrency;
  @JsonKey(name: "sellers_display_sold_price")
  int? sellersDisplaySoldPrice;
  @JsonKey(name: "renewed_at")
  At? renewedAt;
  @JsonKey(name: "created_at")
  At? createdAt;
  @JsonKey(name: "updated_at")
  At? updatedAt;
  @JsonKey(name: "allow_pickups")
  dynamic allowPickups;
  @JsonKey(name: "pickup_city")
  dynamic pickupCity;
  @JsonKey(name: "current_status")
  String? currentStatus;
  @JsonKey(name: "status_type")
  int? statusType;
  @JsonKey(name: "listing_order_status")
  String? listingOrderStatus;
  @JsonKey(name: "listing_order_delivery_status")
  String? listingOrderDeliveryStatus;
  @JsonKey(name: "retail_savings")
  String? retailSavings;
  @JsonKey(name: "rack_location")
  dynamic rackLocation;
  @JsonKey(name: "discount_min_price")
  dynamic discountMinPrice;

  DetailData({
    this.shippingCost,
    this.soldTo,
    this.soldAt,
    this.soldPrice,
    this.soldPriceCurrency,
    this.sellersDisplaySoldCurrency,
    this.sellersDisplaySoldPrice,
    this.renewedAt,
    this.createdAt,
    this.updatedAt,
    this.allowPickups,
    this.pickupCity,
    this.currentStatus,
    this.statusType,
    this.listingOrderStatus,
    this.listingOrderDeliveryStatus,
    this.retailSavings,
    this.rackLocation,
    this.discountMinPrice,
  });

  factory DetailData.fromJson(Map<String, dynamic> json) =>
      _$DetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$DetailDataToJson(this);
}

@JsonSerializable()
class At {
  @JsonKey(name: "date")
  DateTime? date;

  At({
    this.date,
  });

  factory At.fromJson(Map<String, dynamic> json) => _$AtFromJson(json);

  Map<String, dynamic> toJson() => _$AtToJson(this);
}

@JsonSerializable()
class ListingBump {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "listing_id")
  int? listingId;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "purchase_num")
  int? purchaseNum;
  @JsonKey(name: "bump_end_time")
  DateTime? bumpEndTime;
  @JsonKey(name: "last_bump_time")
  DateTime? lastBumpTime;
  @JsonKey(name: "first_bump_time")
  DateTime? firstBumpTime;
  @JsonKey(name: "note")
  dynamic note;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "remaining_bumps")
  int? remainingBumps;
  @JsonKey(name: "next_bump_time")
  DateTime? nextBumpTime;

  ListingBump({
    this.id,
    this.userId,
    this.listingId,
    this.type,
    this.isActive,
    this.purchaseNum,
    this.bumpEndTime,
    this.lastBumpTime,
    this.firstBumpTime,
    this.note,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.remainingBumps,
    this.nextBumpTime,
  });

  factory ListingBump.fromJson(Map<String, dynamic> json) =>
      _$ListingBumpFromJson(json);

  Map<String, dynamic> toJson() => _$ListingBumpToJson(this);
}

@JsonSerializable()
class PrimaryImage {
  @JsonKey(name: "data")
  Dat? data;

  PrimaryImage({
    this.data,
  });

  factory PrimaryImage.fromJson(Map<String, dynamic> json) =>
      _$PrimaryImageFromJson(json);

  Map<String, dynamic> toJson() => _$PrimaryImageToJson(this);
}

@JsonSerializable()
class Dat {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_primary")
  bool? isPrimary;
  @JsonKey(name: "url_thumb")
  String? urlThumb;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "url_details")
  String? urlDetails;
  @JsonKey(name: "url_large")
  String? urlLarge;

  Dat({
    this.id,
    this.isPrimary,
    this.urlThumb,
    this.url,
    this.urlDetails,
    this.urlLarge,
  });

  factory Dat.fromJson(Map<String, dynamic> json) => _$DatFromJson(json);

  Map<String, dynamic> toJson() => _$DatToJson(this);
}

@JsonSerializable()
class SecondaryImages {
  @JsonKey(name: "data")
  List<Dat>? data;

  SecondaryImages({
    this.data,
  });

  factory SecondaryImages.fromJson(Map<String, dynamic> json) =>
      _$SecondaryImagesFromJson(json);

  Map<String, dynamic> toJson() => _$SecondaryImagesToJson(this);
}

@JsonSerializable()
class Sizes {
  @JsonKey(name: "data")
  List<Datum>? data;

  Sizes({
    this.data,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => _$SizesFromJson(json);

  Map<String, dynamic> toJson() => _$SizesToJson(this);

  List<Datum> dedupKeepFirst() {
    final seen = <int?>{};
    return data?.where((e) => seen.add(e.id)).toList() ?? [];
  }
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "brand_id")
  int? brandId;
  @JsonKey(name: "size")
  String? size;
  @JsonKey(name: "standard_size_id")
  int? standardSizeId;
  @JsonKey(name: "generic_size")
  String? genericSize;
  @JsonKey(name: "alt_size")
  String? altSize;
  @JsonKey(name: "alt_size_title")
  String? altSizeTitle;

  Datum({
    this.id,
    this.brandId,
    this.size,
    this.standardSizeId,
    this.genericSize,
    this.altSize,
    this.altSizeTitle,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "data")
  UserDataListingDetail? data;

  User({
    this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserDataListingDetail {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "display_name")
  String? displayName;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "mobile_phone")
  dynamic mobilePhone;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "profile_picture")
  String? profilePicture;
  @JsonKey(name: "display_profile_picture")
  String? displayProfilePicture;
  @JsonKey(name: "is_safe_seller")
  int? isSafeSeller;
  @JsonKey(name: "is_online")
  int? isOnline;
  @JsonKey(name: "last_seen_at")
  At? lastSeenAt;
  @JsonKey(name: "feedback_percentage")
  int? feedbackPercentage;
  @JsonKey(name: "can_send_messages")
  bool? canSendMessages;
  @JsonKey(name: "can_make_offers")
  bool? canMakeOffers;
  @JsonKey(name: "is_holiday_mode")
  bool? isHolidayMode;
  @JsonKey(name: "start_holiday_date")
  dynamic startHolidayDate;
  @JsonKey(name: "end_holiday_date")
  dynamic endHolidayDate;
  @JsonKey(name: "can_make_bulk_upload")
  bool? canMakeBulkUpload;
  @JsonKey(name: "can_make_bank_transfers")
  bool? canMakeBankTransfers;
  @JsonKey(name: "feedback")
  String? feedback;
  @JsonKey(name: "is_following")
  bool? isFollowing;
  @JsonKey(name: "is_dw_store")
  bool? isDwStore;
  @JsonKey(name: "is_top_seller")
  bool? isTopSeller;
  @JsonKey(name: "is_force_braintree")
  bool? isForceBraintree;
  @JsonKey(name: "verified_email")
  bool? verifiedEmail;
  @JsonKey(name: "verified_facebook")
  bool? verifiedFacebook;
  @JsonKey(name: "created_at")
  At? createdAt;
  @JsonKey(name: "Counts")
  FluffyCounts? counts;

  UserDataListingDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.displayName,
    this.username,
    this.mobilePhone,
    this.country,
    this.gender,
    this.profilePicture,
    this.displayProfilePicture,
    this.isSafeSeller,
    this.isOnline,
    this.lastSeenAt,
    this.feedbackPercentage,
    this.canSendMessages,
    this.canMakeOffers,
    this.isHolidayMode,
    this.startHolidayDate,
    this.endHolidayDate,
    this.canMakeBulkUpload,
    this.canMakeBankTransfers,
    this.feedback,
    this.isFollowing,
    this.isDwStore,
    this.isTopSeller,
    this.isForceBraintree,
    this.verifiedEmail,
    this.verifiedFacebook,
    this.createdAt,
    this.counts,
  });

  factory UserDataListingDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDataListingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataListingDetailToJson(this);
}

@JsonSerializable()
class FluffyCounts {
  @JsonKey(name: "data")
  FluffyData? data;

  FluffyCounts({
    this.data,
  });

  factory FluffyCounts.fromJson(Map<String, dynamic> json) =>
      _$FluffyCountsFromJson(json);

  Map<String, dynamic> toJson() => _$FluffyCountsToJson(this);

  int totalFeedback() {
    return (data?.feedbackNegativeCount ?? 0) +
        (data?.feedbackNegativeCount ?? 0) +
        (data?.feedbackNegativeCount ?? 0);
  }
}

@JsonSerializable()
class FluffyData {
  @JsonKey(name: "following_count")
  int? followingCount;
  @JsonKey(name: "followers_count")
  int? followersCount;
  @JsonKey(name: "brands_count")
  int? brandsCount;
  @JsonKey(name: "listing_count")
  int? listingCount;
  @JsonKey(name: "consignment_listing_count")
  int? consignmentListingCount;
  @JsonKey(name: "feedback_positive_count")
  int? feedbackPositiveCount;
  @JsonKey(name: "feedback_neutral_count")
  int? feedbackNeutralCount;
  @JsonKey(name: "feedback_negative_count")
  int? feedbackNegativeCount;

  FluffyData({
    this.followingCount,
    this.followersCount,
    this.brandsCount,
    this.listingCount,
    this.consignmentListingCount,
    this.feedbackPositiveCount,
    this.feedbackNeutralCount,
    this.feedbackNegativeCount,
  });

  factory FluffyData.fromJson(Map<String, dynamic> json) =>
      _$FluffyDataFromJson(json);

  Map<String, dynamic> toJson() => _$FluffyDataToJson(this);
}
