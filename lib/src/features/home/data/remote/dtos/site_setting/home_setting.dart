import 'package:qwid/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/shop_by_price.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/top_brand.dart';
import 'package:json_annotation/json_annotation.dart';
import 'carousel.dart';

part 'home_setting.g.dart';

@JsonSerializable()
class HomeSetting {

  HomeSetting({
    this.topBrand,
    this.category,
    this.shopByPrice,
    this.trendSearch,
    this.carousel
  });

  @JsonKey(name: "top_brand")
  final List<TopBrand>? topBrand;
  @JsonKey()
  final List<CategoryEntity>? category;
  @JsonKey(name: "shop_by_price")
  final List<ShopByPrice>? shopByPrice;
  @JsonKey(name: "trend_search")
  final List<String>? trendSearch;
  @JsonKey()
  final List<Carousel>? carousel;

  factory HomeSetting.fromJson(Map<String, dynamic> json) => _$HomeSettingFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSettingToJson(this);

}