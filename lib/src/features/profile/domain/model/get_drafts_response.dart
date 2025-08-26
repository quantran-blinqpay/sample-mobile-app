// To parse this JSON data, do
//
//     final getDraftsResponse = getDraftsResponseFromJson(jsonString);

import 'package:designerwardrobe/src/features/profile/domain/model/user_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_drafts_response.g.dart';

GetDraftsResponse getDraftsResponseFromJson(String str) =>
    GetDraftsResponse.fromJson(json.decode(str));

String getDraftsResponseToJson(GetDraftsResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetDraftsResponse {
  @JsonKey(name: "data")
  List<GetDraftsResponseDatum>? data;
  @JsonKey(name: "meta")
  Meta? meta;

  GetDraftsResponse({
    this.data,
    this.meta,
  });

  factory GetDraftsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDraftsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDraftsResponseToJson(this);
}

@JsonSerializable()
class GetDraftsResponseDatum {
  @JsonKey(name: "is_blacklisted")
  bool? isBlacklisted;
  @JsonKey(name: "views")
  int? views;
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "is_vintage")
  int? isVintage;
  @JsonKey(name: "is_reduced")
  bool? isReduced;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "price_retail_aud")
  int? priceRetailAud;
  @JsonKey(name: "is_valet")
  bool? isValet;
  @JsonKey(name: "price_retail_nzd")
  int? priceRetailNzd;
  @JsonKey(name: "price_pattern")
  PricePattern? pricePattern;
  @JsonKey(name: "is_hot")
  bool? isHot;
  @JsonKey(name: "is_safe_to_delete")
  bool? isSafeToDelete;
  @JsonKey(name: "in_subs_pool")
  bool? inSubsPool;
  @JsonKey(name: "is_sold")
  bool? isSold;
  @JsonKey(name: "price_original_nzd")
  double? priceOriginalNzd;
  @JsonKey(name: "original_currency")
  String? originalCurrency;
  @JsonKey(name: "is_wanted")
  bool? isWanted;
  @JsonKey(name: "price_nzd")
  double? priceNzd;
  @JsonKey(name: "Sizes")
  Sizes? sizes;
  @JsonKey(name: "is_featured")
  bool? isFeatured;
  @JsonKey(name: "price_original_aud")
  double? priceOriginalAud;
  @JsonKey(name: "is_expired")
  bool? isExpired;
  @JsonKey(name: "retail_saving_percent")
  String? retailSavingPercent;
  @JsonKey(name: "has_tie")
  bool? hasTie;
  @JsonKey(name: "is_consignment")
  int? isConsignment;
  @JsonKey(name: "brand_id")
  int? brandId;
  @JsonKey(name: "rental_url")
  String? rentalUrl;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "User")
  User? user;
  @JsonKey(name: "condition")
  Condition? condition;
  @JsonKey(name: "colour")
  String? colour;
  @JsonKey(name: "is_dw_rental")
  bool? isDwRental;
  @JsonKey(name: "price_nzd_minus_shipping")
  double? priceNzdMinusShipping;
  @JsonKey(name: "is_highlighted")
  bool? isHighlighted;
  @JsonKey(name: "consignor")
  Consignor? consignor;
  @JsonKey(name: "retail_saving_percent_au")
  String? retailSavingPercentAu;
  @JsonKey(name: "price_aud")
  double? priceAud;
  @JsonKey(name: "is_available")
  bool? isAvailable;
  @JsonKey(name: "is_rental")
  bool? isRental;
  @JsonKey(name: "PrimaryImage")
  PrimaryImage? primaryImage;
  @JsonKey(name: "price_shipping_au_to_nz_aud")
  int? priceShippingAuToNzAud;
  @JsonKey(name: "price_shipping_au_to_au_aud")
  int? priceShippingAuToAuAud;
  @JsonKey(name: "brand")
  List<dynamic>? brand;
  @JsonKey(name: "has_shipping_kit")
  bool? hasShippingKit;
  @JsonKey(name: "category")
  Category? category;
  @JsonKey(name: "condition_id")
  int? conditionId;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "price_aud_minus_shipping")
  double? priceAudMinusShipping;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "is_dw_clearance")
  bool? isDwClearance;
  @JsonKey(name: "retail_saving_percent_nz")
  String? retailSavingPercentNz;

  GetDraftsResponseDatum({
    this.isBlacklisted,
    this.views,
    this.urlTitle,
    this.isVintage,
    this.isReduced,
    this.userId,
    this.isActive,
    this.priceRetailAud,
    this.isValet,
    this.priceRetailNzd,
    this.pricePattern,
    this.isHot,
    this.isSafeToDelete,
    this.inSubsPool,
    this.isSold,
    this.priceOriginalNzd,
    this.originalCurrency,
    this.isWanted,
    this.priceNzd,
    this.sizes,
    this.isFeatured,
    this.priceOriginalAud,
    this.isExpired,
    this.retailSavingPercent,
    this.hasTie,
    this.isConsignment,
    this.brandId,
    this.rentalUrl,
    this.id,
    this.user,
    this.condition,
    this.colour,
    this.isDwRental,
    this.priceNzdMinusShipping,
    this.isHighlighted,
    this.consignor,
    this.retailSavingPercentAu,
    this.priceAud,
    this.isAvailable,
    this.isRental,
    this.primaryImage,
    this.priceShippingAuToNzAud,
    this.priceShippingAuToAuAud,
    this.brand,
    this.hasShippingKit,
    this.category,
    this.conditionId,
    this.url,
    this.priceAudMinusShipping,
    this.title,
    this.isDwClearance,
    this.retailSavingPercentNz,
  });

  factory GetDraftsResponseDatum.fromJson(Map<String, dynamic> json) =>
      _$GetDraftsResponseDatumFromJson(json);

  Map<String, dynamic> toJson() => _$GetDraftsResponseDatumToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "id")
  int? id;

  Category({
    this.urlTitle,
    this.title,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Condition {
  @JsonKey(name: "sub_title")
  String? subTitle;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "id")
  int? id;

  Condition({
    this.subTitle,
    this.title,
    this.id,
  });

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

@JsonSerializable()
class Consignor {
  Consignor();

  factory Consignor.fromJson(Map<String, dynamic> json) =>
      _$ConsignorFromJson(json);

  Map<String, dynamic> toJson() => _$ConsignorToJson(this);
}

@JsonSerializable()
class PricePattern {
  @JsonKey(
      name: 'shipping_to_au',
      fromJson: _shippingToListFromJson,
      toJson: _shippingToListToJson)
  final List<ShippingTo> shippingToAu;
  @JsonKey(name: "original_price")
  double? originalPrice;
  @JsonKey(name: "shipping_to_nz")
  ShippingTo? shippingToNz;
  @JsonKey(name: "currency")
  String? currency;
  @JsonKey(name: "sale_price_without_shipping_fee")
  int? salePriceWithoutShippingFee;

  PricePattern({
    this.shippingToAu = const [],
    this.originalPrice,
    this.shippingToNz,
    this.currency,
    this.salePriceWithoutShippingFee,
  });

  factory PricePattern.fromJson(Map<String, dynamic> json) =>
      _$PricePatternFromJson(json);

  Map<String, dynamic> toJson() => _$PricePatternToJson(this);

  static List<ShippingTo> _shippingToListFromJson(Object? json) {
    if (json == null) return const [];

    if (json is Map<String, dynamic>) {
      return [ShippingTo.fromJson(json)];
    }
    if (json is List) {
      return json
          .whereType<Map<String, dynamic>>()
          .map(ShippingTo.fromJson)
          .toList();
    }
    throw FormatException(
        'Unexpected type for shipping_to_*: ${json.runtimeType}');
  }

  static Object? _shippingToListToJson(List<ShippingTo> v) =>
      v.map((e) => e.toJson()).toList();
}

@JsonSerializable()
class ShippingTo {
  @JsonKey(name: "currency")
  String? currency;
  @JsonKey(name: "amount")
  int? amount;

  ShippingTo({
    this.currency,
    this.amount,
  });

  factory ShippingTo.fromJson(Map<String, dynamic> json) =>
      _$ShippingToFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingToToJson(this);
}

@JsonSerializable()
class PrimaryImage {
  @JsonKey(name: "data")
  PrimaryImageData? data;

  PrimaryImage({
    this.data,
  });

  factory PrimaryImage.fromJson(Map<String, dynamic> json) =>
      _$PrimaryImageFromJson(json);

  Map<String, dynamic> toJson() => _$PrimaryImageToJson(this);
}

@JsonSerializable()
class PrimaryImageData {
  @JsonKey(name: "url_details")
  String? urlDetails;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_primary")
  bool? isPrimary;
  @JsonKey(name: "url_large")
  String? urlLarge;
  @JsonKey(name: "url_thumb")
  String? urlThumb;

  PrimaryImageData({
    this.urlDetails,
    this.url,
    this.id,
    this.isPrimary,
    this.urlLarge,
    this.urlThumb,
  });

  factory PrimaryImageData.fromJson(Map<String, dynamic> json) =>
      _$PrimaryImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrimaryImageDataToJson(this);
}

@JsonSerializable()
class Sizes {
  @JsonKey(name: "data")
  List<SizesDatum>? data;

  Sizes({
    this.data,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => _$SizesFromJson(json);

  Map<String, dynamic> toJson() => _$SizesToJson(this);
}

@JsonSerializable()
class SizesDatum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "alt_size_title")
  String? altSizeTitle;
  @JsonKey(name: "size")
  String? size;
  @JsonKey(name: "alt_size")
  String? altSize;
  @JsonKey(name: "brand_id")
  int? brandId;
  @JsonKey(name: "standard_size_id")
  int? standardSizeId;
  @JsonKey(name: "generic_size")
  String? genericSize;

  SizesDatum({
    this.id,
    this.altSizeTitle,
    this.size,
    this.altSize,
    this.brandId,
    this.standardSizeId,
    this.genericSize,
  });

  factory SizesDatum.fromJson(Map<String, dynamic> json) =>
      _$SizesDatumFromJson(json);

  Map<String, dynamic> toJson() => _$SizesDatumToJson(this);
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
class Meta {
  @JsonKey(name: "pagination")
  Pagination? pagination;

  Meta({
    this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "count")
  int? count;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "links")
  Consignor? links;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "total_pages")
  int? totalPages;

  Pagination({
    this.count,
    this.total,
    this.links,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}