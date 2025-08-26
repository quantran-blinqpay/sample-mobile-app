import 'package:json_annotation/json_annotation.dart';

part 'create_listing_model.g.dart';

@JsonSerializable()
class CreateListingModel {
  @JsonKey(name: "listing_id")
  String? listingId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "brand_id")
  int? brandId;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "condition_id")
  int? conditionId;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "size_ids")
  String? sizeIds;
  @JsonKey(name: "colour")
  String? colour;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "price_retail")
  String? priceRetail;
  @JsonKey(name: "upload_ids")
  String? uploadIds;
  @JsonKey(name: "primary_image_id")
  String? primaryImageId;
  @JsonKey(name: "listing_sale_type")
  String? listingSaleType;
  @JsonKey(name: "is_vintage")
  bool? isVintage;
  @JsonKey(name: "enable_buy_now_pay_later")
  bool? enableBuyNowPayLater;
  @JsonKey(name: "shipping_to_au")
  String? shippingToAu;
  @JsonKey(name: "shipping_to_nz")
  String? shippingToNz;
  @JsonKey(name: "listing_item_version")
  String? listingItemVersion;

  CreateListingModel({
    this.listingId,
    this.title,
    this.brandId,
    this.categoryId,
    this.conditionId,
    this.description,
    this.sizeIds,
    this.colour,
    this.price,
    this.priceRetail,
    this.uploadIds,
    this.primaryImageId,
    this.listingSaleType,
    this.isVintage,
    this.enableBuyNowPayLater,
    this.shippingToAu,
    this.shippingToNz,
    this.listingItemVersion,
  });

  factory CreateListingModel.fromJson(Map<String, dynamic> json) =>
      _$CreateListingModelFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (listingId?.isNotEmpty ?? false) 'listing_id': listingId,
        'title': title,
        'brand_id': brandId,
        'category_id': categoryId,
        'condition_id': conditionId,
        'description': description,
        'size_ids': sizeIds,
        'colour': colour,
        'price': price,
        'price_retail': priceRetail,
        'upload_ids': uploadIds,
        'primary_image_id': primaryImageId,
        'listing_sale_type': listingSaleType,
        'is_vintage': isVintage,
        'enable_buy_now_pay_later': enableBuyNowPayLater,
        'shipping_to_au': shippingToAu,
        'shipping_to_nz': shippingToNz,
        'listing_item_version': listingItemVersion,
      };
}
