import 'package:json_annotation/json_annotation.dart';

part 'product_info.g.dart';

@JsonSerializable()
class ProductInfo {
  @JsonKey(name: "alt_sizes")
  final List<String>? altSizes;
  @JsonKey()
  final String? brand;
  @JsonKey(name: "brand_id")
  final String? brandId;
  @JsonKey(name: "brand_slug")
  final String? brandSlug;
  @JsonKey(name: "can_ship_to_au")
  final bool? canShipToAu;
  @JsonKey(name: "can_ship_to_nz")
  final bool? canShipToNz;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "cio_image_url")
  final String? cioImageUrl;
  @JsonKey()
  final List<String>? colors;
  @JsonKey(name: "created_at")
  final int? createdAt;
  @JsonKey()
  final String? description;
  @JsonKey(name: "generic_sizes")
  final List<String>? genericSizes;
  @JsonKey(name: "image_url")
  final String? imageUrl;
  @JsonKey(name: "is_available")
  final bool? isAvailable;
  @JsonKey(name: "location")
  final String? location;
  @JsonKey(name: "number_of_watchers")
  final int? numberOfWatchers;
  @JsonKey(name: "original_price")
  final int? originalPrice;
  @JsonKey(name: "parent_categories")
  final List<String>? parentCategories;
  @JsonKey(name: "price_aud")
  final double? priceAud;
  @JsonKey(name: "price_nzd")
  final double? priceNzd;
  @JsonKey(name: "price_pattern_currency")
  final String? pricePatternCurrency;
  @JsonKey(name: "renewed_at")
  final int? renewedAt;
  @JsonKey(name: "sale_price_au")
  final int? salePriceAu;
  @JsonKey(name: "sale_price_nz")
  final int? salePriceNz;
  @JsonKey(name: "sale_price_without_shipping_fee")
  final int? salePriceWithoutShippingFee;
  @JsonKey(name: "seller_id")
  final String? sellerId;
  @JsonKey(name: "shipping_to_au_amount")
  final int? shippingToAuAmount;
  @JsonKey(name: "shipping_to_au_currency")
  final String? shippingToAuCurrency;
  @JsonKey(name: "shipping_to_nz_amount")
  final int? shippingToNzAmount;
  @JsonKey(name: "shipping_to_nz_currency")
  final String? shippingToNzCurrency;
  @JsonKey(name: "sizes_str")
  final String? sizesStr;
  @JsonKey()
  final String? title;
  @JsonKey()
  final String? url;
  @JsonKey(name: "url_title")
  final String? urlTitle;

  ProductInfo({
    this.altSizes,
    this.brand,
    this.brandId,
    this.brandSlug,
    this.canShipToAu,
    this.canShipToNz,
    this.category,
    this.categoryId,
    this.cioImageUrl,
    this.colors,
    this.createdAt,
    this.description,
    this.genericSizes,
    this.imageUrl,
    this.isAvailable,
    this.location,
    this.numberOfWatchers,
    this.originalPrice,
    this.parentCategories,
    this.priceAud,
    this.priceNzd,
    this.pricePatternCurrency,
    this.renewedAt,
    this.salePriceAu,
    this.salePriceNz,
    this.salePriceWithoutShippingFee,
    this.sellerId,
    this.shippingToAuAmount,
    this.shippingToAuCurrency,
    this.shippingToNzAmount,
    this.shippingToNzCurrency,
    this.sizesStr,
    this.title,
    this.url,
    this.urlTitle,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);

  bool get isSale {
    return (salePriceWithoutShippingFee ?? 0) < (originalPrice ?? 0);
  }

  num? calSalePrice(String userCurrency, double rate) {
    if (userCurrency.toLowerCase() == 'nz') {
      final num =
          ((salePriceWithoutShippingFee ?? 0) + (shippingToNzAmount ?? 0));

      if (pricePatternCurrency?.contains(userCurrency.toLowerCase()) ?? false) {
        return num;
      }

      return num * rate;
    }

    final num =
        ((salePriceWithoutShippingFee ?? 0) + (shippingToAuAmount ?? 0));

    if (pricePatternCurrency?.contains(userCurrency.toLowerCase()) ?? false) {
      return num;
    }
    return num * rate;
  }

  num? calOriginalPrice(String userCurrency, double rate) {
    if (userCurrency.toLowerCase() == 'nz') {
      final num = ((originalPrice ?? 0) + (shippingToNzAmount ?? 0));

      if (pricePatternCurrency?.contains(userCurrency.toLowerCase()) ?? false) {
        return num;
      }

      return num * rate;
    }

    final num = ((originalPrice ?? 0) + (shippingToAuAmount ?? 0));

    if (pricePatternCurrency?.contains(userCurrency.toLowerCase()) ?? false) {
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
