import 'package:json_annotation/json_annotation.dart';

part 'filter_hits_response.g.dart';

@JsonSerializable()
class FilterHitsResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_available")
  bool? isAvailable;
  @JsonKey(name: "seller_id")
  int? sellerId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "suggestion_title")
  String? suggestionTitle;
  @JsonKey(name: "suggestion_title_with_brand_slug")
  String? suggestionTitleWithBrandSlug;
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "state")
  dynamic state;
  @JsonKey(name: "User")
  User? user;
  @JsonKey(name: "Brand")
  Brand? brand;
  @JsonKey(name: "Sizes")
  Sizes? sizes;
  @JsonKey(name: "Tags")
  Sizes? tags;
  @JsonKey(name: "colour")
  String? colour;
  @JsonKey(name: "colors")
  List<String>? colors;
  @JsonKey(name: "Category")
  Category? category;
  @JsonKey(name: "parent_categories")
  List<String>? parentCategories;
  @JsonKey(name: "parent_categories_string")
  String? parentCategoriesString;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "primary_image_url")
  String? primaryImageUrl;
  @JsonKey(name: "cropped_image_url")
  String? croppedImageUrl;
  @JsonKey(name: "listed_timestamp")
  String? listedTimestamp;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "price_retail")
  int? priceRetail;
  @JsonKey(name: "price_retail_nzd")
  int? priceRetailNzd;
  @JsonKey(name: "price_retail_aud")
  int? priceRetailAud;
  @JsonKey(name: "price_nzd")
  int? priceNzd;
  @JsonKey(name: "price_aud")
  double? priceAud;
  @JsonKey(name: "original_currency")
  String? originalCurrency;
  @JsonKey(name: "retail_saving_percent_nz")
  String? retailSavingPercentNz;
  @JsonKey(name: "retail_saving_percent_au")
  String? retailSavingPercentAu;
  @JsonKey(name: "retail_saving_percent_nz_int")
  int? retailSavingPercentNzInt;
  @JsonKey(name: "retail_saving_percent_au_int")
  int? retailSavingPercentAuInt;
  @JsonKey(name: "original_saving_percent_nz")
  String? originalSavingPercentNz;
  @JsonKey(name: "original_saving_percent_au")
  String? originalSavingPercentAu;
  @JsonKey(name: "price_nzd_original")
  dynamic priceNzdOriginal;
  @JsonKey(name: "price_aud_original")
  dynamic priceAudOriginal;
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
  @JsonKey(name: "is_hot")
  bool? isHot;
  @JsonKey(name: "is_reduced")
  bool? isReduced;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "is_expired")
  bool? isExpired;
  @JsonKey(name: "is_blacklisted")
  bool? isBlacklisted;
  @JsonKey(name: "is_available_in_store")
  bool? isAvailableInStore;
  @JsonKey(name: "is_deleted")
  bool? isDeleted;
  @JsonKey(name: "is_new")
  bool? isNew;
  @JsonKey(name: "is_consignment")
  bool? isConsignment;
  @JsonKey(name: "in_subs_pool")
  bool? inSubsPool;
  @JsonKey(name: "consignor_user_id")
  int? consignorUserId;
  @JsonKey(name: "recycle_consignor_id")
  dynamic recycleConsignorId;
  @JsonKey(name: "listing_style_id")
  dynamic listingStyleId;
  @JsonKey(name: "has_stock")
  bool? hasStock;
  @JsonKey(name: "stock_count")
  int? stockCount;
  @JsonKey(name: "sortByTime")
  int? sortByTime;
  @JsonKey(name: "created_at")
  int? createdAt;
  @JsonKey(name: "updated_at")
  int? updatedAt;
  @JsonKey(name: "expired_at")
  dynamic expiredAt;
  @JsonKey(name: "in_backup_pool")
  bool? inBackupPool;
  @JsonKey(name: "can_not_ship_to_nz")
  bool? canNotShipToNz;
  @JsonKey(name: "can_not_ship_to_au")
  bool? canNotShipToAu;
  @JsonKey(name: "location")
  String? location;
  @JsonKey(name: "condition")
  String? condition;
  @JsonKey(name: "first_active_bump")
  FirstActiveBump? firstActiveBump;
  @JsonKey(name: "renewed_at")
  int? renewedAt;
  @JsonKey(name: "is_seller_first_5_listings")
  bool? isSellerFirst5Listings;
  @JsonKey(name: "shipping_countries")
  List<String>? shippingCountries;
  @JsonKey(name: "number_of_questions")
  int? numberOfQuestions;
  @JsonKey(name: "number_of_watchers")
  int? numberOfWatchers;
  @JsonKey(name: "views")
  int? views;
  @JsonKey(name: "seller_positive_feedback_percentage")
  int? sellerPositiveFeedbackPercentage;
  @JsonKey(name: "seller_follower_count")
  dynamic sellerFollowerCount;
  @JsonKey(name: "is_bumped")
  bool? isBumped;
  @JsonKey(name: "price_pattern")
  PricePattern? pricePattern;
  @JsonKey(name: "sorting_price_nzd")
  int? sortingPriceNzd;
  @JsonKey(name: "sorting_price_aud")
  double? sortingPriceAud;
  @JsonKey(name: "PrimaryImage")
  PrimaryImage? primaryImage;

  FilterHitsResponse({
    this.id,
    this.isAvailable,
    this.sellerId,
    this.title,
    this.suggestionTitle,
    this.suggestionTitleWithBrandSlug,
    this.urlTitle,
    this.state,
    this.user,
    this.brand,
    this.sizes,
    this.tags,
    this.colour,
    this.colors,
    this.category,
    this.parentCategories,
    this.parentCategoriesString,
    this.description,
    this.primaryImageUrl,
    this.croppedImageUrl,
    this.listedTimestamp,
    this.url,
    this.price,
    this.priceRetail,
    this.priceRetailNzd,
    this.priceRetailAud,
    this.priceNzd,
    this.priceAud,
    this.originalCurrency,
    this.retailSavingPercentNz,
    this.retailSavingPercentAu,
    this.retailSavingPercentNzInt,
    this.retailSavingPercentAuInt,
    this.originalSavingPercentNz,
    this.originalSavingPercentAu,
    this.priceNzdOriginal,
    this.priceAudOriginal,
    this.isWanted,
    this.isFeatured,
    this.isValet,
    this.isVintage,
    this.isSold,
    this.isHot,
    this.isReduced,
    this.isActive,
    this.isExpired,
    this.isBlacklisted,
    this.isAvailableInStore,
    this.isDeleted,
    this.isNew,
    this.isConsignment,
    this.inSubsPool,
    this.consignorUserId,
    this.recycleConsignorId,
    this.listingStyleId,
    this.hasStock,
    this.stockCount,
    this.sortByTime,
    this.createdAt,
    this.updatedAt,
    this.expiredAt,
    this.inBackupPool,
    this.canNotShipToNz,
    this.canNotShipToAu,
    this.location,
    this.condition,
    this.firstActiveBump,
    this.renewedAt,
    this.isSellerFirst5Listings,
    this.shippingCountries,
    this.numberOfQuestions,
    this.numberOfWatchers,
    this.views,
    this.sellerPositiveFeedbackPercentage,
    this.sellerFollowerCount,
    this.isBumped,
    this.pricePattern,
    this.sortingPriceNzd,
    this.sortingPriceAud,
    this.primaryImage,
  });

  factory FilterHitsResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterHitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterHitsResponseToJson(this);
}

@JsonSerializable()
class Brand {
  @JsonKey(name: "data")
  BrandData? data;

  Brand({
    this.data,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BrandData {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_high_street")
  int? isHighStreet;
  @JsonKey(name: "is_valet")
  int? isValet;
  @JsonKey(name: "is_top_100")
  int? isTop100;
  @JsonKey(name: "is_top_100_rental")
  int? isTop100Rental;
  @JsonKey(name: "top_sort")
  int? topSort;
  @JsonKey(name: "top_sort_rental")
  int? topSortRental;
  @JsonKey(name: "is_trending_valet")
  int? isTrendingValet;
  @JsonKey(name: "is_trending_rent")
  int? isTrendingRent;
  @JsonKey(name: "is_trending_shop")
  int? isTrendingShop;
  @JsonKey(name: "is_popular")
  int? isPopular;
  @JsonKey(name: "is_womens")
  int? isWomens;
  @JsonKey(name: "is_mens")
  int? isMens;
  @JsonKey(name: "is_kids")
  int? isKids;
  @JsonKey(name: "is_home")
  int? isHome;
  @JsonKey(name: "is_beauty")
  int? isBeauty;
  @JsonKey(name: "image_large")
  String? imageLarge;
  @JsonKey(name: "image_thumb")
  String? imageThumb;

  BrandData({
    this.id,
    this.title,
    this.urlTitle,
    this.description,
    this.isHighStreet,
    this.isValet,
    this.isTop100,
    this.isTop100Rental,
    this.topSort,
    this.topSortRental,
    this.isTrendingValet,
    this.isTrendingRent,
    this.isTrendingShop,
    this.isPopular,
    this.isWomens,
    this.isMens,
    this.isKids,
    this.isHome,
    this.isBeauty,
    this.imageLarge,
    this.imageThumb,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) =>
      _$BrandDataFromJson(json);

  Map<String, dynamic> toJson() => _$BrandDataToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "data")
  CategoryData? data;

  Category({
    this.data,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoryData {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url_title")
  String? urlTitle;

  CategoryData({
    this.id,
    this.title,
    this.urlTitle,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}

@JsonSerializable()
class FirstActiveBump {
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

  FirstActiveBump({
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

  factory FirstActiveBump.fromJson(Map<String, dynamic> json) =>
      _$FirstActiveBumpFromJson(json);

  Map<String, dynamic> toJson() => _$FirstActiveBumpToJson(this);
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
  @JsonKey(
    name: 'shipping_to_au',
    fromJson: _shippingAuFromJson,
    toJson: _shippingAuToJson,
  )
  final ShippingTo? shippingToAu;

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

  static ShippingTo? _shippingAuFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return ShippingTo.fromJson(json);
    }
    return null;
  }

  static dynamic _shippingAuToJson(ShippingTo? info) =>
      info == null ? {} : info.toJson();

  bool get isSale {
    return (salePriceWithoutShippingFee ?? 0) < (originalPrice ?? 0);
  }

  num? calSalePrice(String userCurrency, double rate) {
    if (userCurrency.toLowerCase() == 'nz') {
      final num =
          ((salePriceWithoutShippingFee ?? 0) + (shippingToNz?.amount ?? 0));

      if (currency?.contains(userCurrency.toLowerCase()) ?? false) {
        return num;
      }

      return num * rate;
    }

    final num =
        ((salePriceWithoutShippingFee ?? 0) + (shippingToAu?.amount ?? 0));

    if (currency?.contains(userCurrency.toLowerCase()) ?? false) {
      return num;
    }
    return num * rate;
  }

  num? calOriginalPrice(String userCurrency, double rate) {
    if (userCurrency.toLowerCase() == 'nz') {
      final num = ((originalPrice ?? 0) + (shippingToNz?.amount ?? 0));

      if (currency?.contains(userCurrency.toLowerCase()) ?? false) {
        return num;
      }

      return num * rate;
    }

    final num = ((originalPrice ?? 0) + (shippingToAu?.amount ?? 0));

    if (currency?.contains(userCurrency.toLowerCase()) ?? false) {
      return num;
    }
    return num * rate;
  }

  int calDiscountPercent({
    required num salePrice,
    required num originalPrice,
  }) {
    if (originalPrice <= 0 || salePrice < 0) return 0;

    final double percentOff = 100 * (1 - (salePrice / originalPrice));
    return percentOff < 0 ? 0 : percentOff.floor();
  }
}

@JsonSerializable()
class ShippingTo {
  @JsonKey(name: "amount")
  num? amount;
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

  PrimaryImageData({
    this.id,
    this.isPrimary,
    this.urlThumb,
    this.url,
    this.urlDetails,
    this.urlLarge,
  });

  factory PrimaryImageData.fromJson(Map<String, dynamic> json) =>
      _$PrimaryImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrimaryImageDataToJson(this);
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
  @JsonKey(name: "is_spotlight")
  bool? isSpotlight;
  @JsonKey(name: "is_top_seller")
  bool? isTopSeller;

  UserData({
    this.id,
    this.isSpotlight,
    this.isTopSeller,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
