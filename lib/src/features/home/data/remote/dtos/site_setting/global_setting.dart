import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/recommended_brand_au_setting.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/recommended_brand_nz_setting.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/shop_by_price.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/top_brand.dart';
import 'package:json_annotation/json_annotation.dart';
import 'carousel.dart';

part 'global_setting.g.dart';

@JsonSerializable()
class GlobalSetting {
  GlobalSetting({
    this.nzBrand,
    this.auBrand,
  });

  @JsonKey(name: "recommend_brands_nz")
  final RecommendedBrandNZSetting? nzBrand;
  @JsonKey(name: "recommend_brands_au")
  final RecommendedBrandAUSetting? auBrand;
  @JsonKey(name: "default_shipping_fee")
  DefaultShippingFee? defaultShippingFee;

  factory GlobalSetting.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalSettingToJson(this);
}

@JsonSerializable()
class DefaultShippingFee {
  @JsonKey(name: "default_nz_to_au_fee_for_nz_user")
  int? defaultNzToAuFeeForNzUser;

  DefaultShippingFee({
    this.defaultNzToAuFeeForNzUser,
  });

  factory DefaultShippingFee.fromJson(Map<String, dynamic> json) =>
      _$DefaultShippingFeeFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultShippingFeeToJson(this);
}
