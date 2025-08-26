// To parse this JSON data, do
//
//     final allQuestionResponse = allQuestionResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'all_question_response.g.dart';

AllQuestionResponse allQuestionResponseFromJson(String str) => AllQuestionResponse.fromJson(json.decode(str));

String allQuestionResponseToJson(AllQuestionResponse data) => json.encode(data.toJson());

@JsonSerializable()
class AllQuestionResponse {
    @JsonKey(name: "data")
    List<Datum>? data;

    AllQuestionResponse({
        this.data,
    });

    factory AllQuestionResponse.fromJson(Map<String, dynamic> json) => _$AllQuestionResponseFromJson(json);

    Map<String, dynamic> toJson() => _$AllQuestionResponseToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "user_id")
    int? userId;
    @JsonKey(name: "listing_id")
    int? listingId;
    @JsonKey(name: "question")
    String? question;
    @JsonKey(name: "is_answered")
    bool? isAnswered;
    @JsonKey(name: "is_private")
    bool? isPrivate;
    @JsonKey(name: "created_at")
    At? createdAt;
    @JsonKey(name: "updated_at")
    At? updatedAt;
    @JsonKey(name: "Answer")
    Answer? answer;
    @JsonKey(name: "Listing")
    Listing? listing;
    @JsonKey(name: "User")
    User? user;

    Datum({
        this.id,
        this.userId,
        this.listingId,
        this.question,
        this.isAnswered,
        this.isPrivate,
        this.createdAt,
        this.updatedAt,
        this.answer,
        this.listing,
        this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Answer {
    @JsonKey(name: "data")
    AnswerData? data;

    Answer({
        this.data,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

    Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

@JsonSerializable()
class AnswerData {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "question_id")
    int? questionId;
    @JsonKey(name: "answer")
    String? answer;
    @JsonKey(name: "created_at")
    At? createdAt;
    @JsonKey(name: "updated_at")
    At? updatedAt;

    AnswerData({
        this.id,
        this.questionId,
        this.answer,
        this.createdAt,
        this.updatedAt,
    });

    factory AnswerData.fromJson(Map<String, dynamic> json) => _$AnswerDataFromJson(json);

    Map<String, dynamic> toJson() => _$AnswerDataToJson(this);
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
class Listing {
    @JsonKey(name: "data")
    ListingData? data;

    Listing({
        this.data,
    });

    factory Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);

    Map<String, dynamic> toJson() => _$ListingToJson(this);
}

@JsonSerializable()
class ListingData {
    @JsonKey(name: "id")
    int? id;
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
    @JsonKey(name: "size")
    String? size;
    @JsonKey(name: "size_description")
    dynamic sizeDescription;
    @JsonKey(name: "state")
    dynamic state;
    @JsonKey(name: "colour")
    String? colour;
    @JsonKey(name: "display_price")
    String? displayPrice;
    @JsonKey(name: "nz_price")
    String? nzPrice;
    @JsonKey(name: "au_price")
    double? auPrice;
    @JsonKey(name: "price_nzd_minus_shipping")
    int? priceNzdMinusShipping;
    @JsonKey(name: "price_aud_minus_shipping")
    double? priceAudMinusShipping;
    @JsonKey(name: "original_currency")
    String? originalCurrency;
    @JsonKey(name: "display_currency")
    String? displayCurrency;
    @JsonKey(name: "should_show_currency")
    bool? shouldShowCurrency;
    @JsonKey(name: "price_retail")
    dynamic priceRetail;
    @JsonKey(name: "price_retail_nzd")
    dynamic priceRetailNzd;
    @JsonKey(name: "price_retail_aud")
    String? priceRetailAud;
    @JsonKey(name: "price_shipping_nz")
    int? priceShippingNz;
    @JsonKey(name: "price_shipping_au")
    int? priceShippingAu;
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
    @JsonKey(name: "is_wanted")
    bool? isWanted;
    @JsonKey(name: "is_featured")
    bool? isFeatured;
    @JsonKey(name: "is_valet")
    bool? isValet;
    @JsonKey(name: "is_sold")
    bool? isSold;
    @JsonKey(name: "display_watchlist_heart")
    bool? displayWatchlistHeart;
    @JsonKey(name: "is_in_watchlist")
    bool? isInWatchlist;
    @JsonKey(name: "number_of_watchers")
    int? numberOfWatchers;
    @JsonKey(name: "url")
    String? url;
    @JsonKey(name: "is_expired")
    bool? isExpired;
    @JsonKey(name: "is_reduced")
    bool? isReduced;
    @JsonKey(name: "owner_deleted")
    bool? ownerDeleted;
    @JsonKey(name: "is_blacklisted")
    bool? isBlacklisted;
    @JsonKey(name: "is_active")
    bool? isActive;
    @JsonKey(name: "is_hot")
    bool? isHot;
    @JsonKey(name: "valet_status")
    dynamic valetStatus;
    @JsonKey(name: "has_stock")
    bool? hasStock;
    @JsonKey(name: "stock_count")
    int? stockCount;
    @JsonKey(name: "cleaning_type")
    dynamic cleaningType;
    @JsonKey(name: "rental_status")
    dynamic rentalStatus;
    @JsonKey(name: "views")
    int? views;
    @JsonKey(name: "is_essential_listing")
    bool? isEssentialListing;
    @JsonKey(name: "has_shipping_kit")
    bool? hasShippingKit;
    @JsonKey(name: "display_book_a_courier_pickup")
    bool? displayBookACourierPickup;
    @JsonKey(name: "recycle_consignor_id")
    int? recycleConsignorId;
    @JsonKey(name: "price_pattern")
    PricePattern? pricePattern;

    ListingData({
        this.id,
        this.userId,
        this.title,
        this.urlTitle,
        this.brand,
        this.category,
        this.size,
        this.sizeDescription,
        this.state,
        this.colour,
        this.displayPrice,
        this.nzPrice,
        this.auPrice,
        this.priceNzdMinusShipping,
        this.priceAudMinusShipping,
        this.originalCurrency,
        this.displayCurrency,
        this.shouldShowCurrency,
        this.priceRetail,
        this.priceRetailNzd,
        this.priceRetailAud,
        this.priceShippingNz,
        this.priceShippingAu,
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
        this.isWanted,
        this.isFeatured,
        this.isValet,
        this.isSold,
        this.displayWatchlistHeart,
        this.isInWatchlist,
        this.numberOfWatchers,
        this.url,
        this.isExpired,
        this.isReduced,
        this.ownerDeleted,
        this.isBlacklisted,
        this.isActive,
        this.isHot,
        this.valetStatus,
        this.hasStock,
        this.stockCount,
        this.cleaningType,
        this.rentalStatus,
        this.views,
        this.isEssentialListing,
        this.hasShippingKit,
        this.displayBookACourierPickup,
        this.recycleConsignorId,
        this.pricePattern,
    });

    factory ListingData.fromJson(Map<String, dynamic> json) => _$ListingDataFromJson(json);

    Map<String, dynamic> toJson() => _$ListingDataToJson(this);
}

@JsonSerializable()
class Brand {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "url_title")
    String? urlTitle;

    Brand({
        this.id,
        this.title,
        this.urlTitle,
    });

    factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

    Map<String, dynamic> toJson() => _$BrandToJson(this);
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

    factory PricePattern.fromJson(Map<String, dynamic> json) => _$PricePatternFromJson(json);

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

    factory ShippingTo.fromJson(Map<String, dynamic> json) => _$ShippingToFromJson(json);

    Map<String, dynamic> toJson() => _$ShippingToToJson(this);
}

@JsonSerializable()
class User {
    @JsonKey(name: "data")
    UserData? data;

    User({
        this.data,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserData {
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

    UserData({
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
    });

    factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

    Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
