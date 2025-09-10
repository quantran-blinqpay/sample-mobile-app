import 'package:qwid/src/features/home/data/remote/dtos/site_setting/home_setting.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/site_homepage_slides.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../home/data/remote/dtos/site_setting/global_setting.dart';

part 'site_setting_data.g.dart';

@JsonSerializable()
class SiteSettingData {
  SiteSettingData({
    this.listingBump,
    this.home,
    this.siteHomepageSlides,
    this.global,
    this.rural,
  });
  @JsonKey(name: "listing_bump")
  ListingBump? listingBump;
  @JsonKey()
  final HomeSetting? home;
  @JsonKey()
  final GlobalSetting? global;
  @JsonKey(name: 'site_homepage_slides')
  final SiteHomepageSlides? siteHomepageSlides;
  @JsonKey(name: "rural")
  Rural? rural;

  factory SiteSettingData.fromJson(Map<String, dynamic> json) =>
      _$SiteSettingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SiteSettingDataToJson(this);
}

@JsonSerializable()
class ListingBump {
  @JsonKey(name: "top_once_only")
  HighlightAndTopDaily? topOnceOnly;
  @JsonKey(name: "highlight_and_top_daily")
  HighlightAndTopDaily? highlightAndTopDaily;

  ListingBump({
    this.topOnceOnly,
    this.highlightAndTopDaily,
  });

  factory ListingBump.fromJson(Map<String, dynamic> json) =>
      _$ListingBumpFromJson(json);

  Map<String, dynamic> toJson() => _$ListingBumpToJson(this);
}

@JsonSerializable()
class HighlightAndTopDaily {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "key")
  String? key;
  @JsonKey(name: "text")
  String? text;
  @JsonKey(name: "price_nzd_1day")
  double? priceNzd1Day;
  @JsonKey(name: "price_nzd_3day")
  double? priceNzd3Day;
  @JsonKey(name: "price_nzd_7day")
  double? priceNzd7Day;
  @JsonKey(name: "max_number")
  int? maxNumber;
  @JsonKey(name: "bump_interval")
  int? bumpInterval;
  @JsonKey(name: "background_color")
  String? backgroundColor;
  @JsonKey(name: "enable_on_app")
  int? enableOnApp;
  @JsonKey(name: "enable_on_web")
  int? enableOnWeb;

  HighlightAndTopDaily({
    this.name,
    this.key,
    this.text,
    this.priceNzd1Day,
    this.priceNzd3Day,
    this.priceNzd7Day,
    this.maxNumber,
    this.bumpInterval,
    this.backgroundColor,
    this.enableOnApp,
    this.enableOnWeb,
  });

  factory HighlightAndTopDaily.fromJson(Map<String, dynamic> json) =>
      _$HighlightAndTopDailyFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightAndTopDailyToJson(this);
}

@JsonSerializable()
class Rural {
  @JsonKey(name: "price")
  Price? price;

  Rural({
    this.price,
  });

  factory Rural.fromJson(Map<String, dynamic> json) => _$RuralFromJson(json);

  Map<String, dynamic> toJson() => _$RuralToJson(this);
}

@JsonSerializable()
class Price {
  @JsonKey(name: "for_buyer")
  String? forBuyer;
  @JsonKey(name: "for_seller")
  String? forSeller;

  Price({
    this.forBuyer,
    this.forSeller,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
