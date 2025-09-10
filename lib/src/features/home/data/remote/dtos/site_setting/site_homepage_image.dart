import 'package:qwid/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/shop_by_price.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/top_brand.dart';
import 'package:json_annotation/json_annotation.dart';
import 'carousel.dart';

part 'site_homepage_image.g.dart';

@JsonSerializable()
class SiteHomepageImage {

  SiteHomepageImage({
    this.imageUrlWeb,
    this.imageLink,
    this.imageText,
    this.imageUrlMobile,
    this.imageUrlApp,
    this.priority,
    this.subText,
    this.hrefText,
    this.buttonText,
    this.buttonLink,
    this.bgColor,
    this.textPosition,
  });

  @JsonKey(name: "image_url_web")
  final String? imageUrlWeb;
  @JsonKey(name: "image_link")
  final String? imageLink;
  @JsonKey(name: "image_text")
  final String? imageText;
  @JsonKey(name: "image_url_mobile")
  final String? imageUrlMobile;
  @JsonKey(name: "image_url_app")
  final String? imageUrlApp;
  @JsonKey()
  final int? priority;
  @JsonKey(name: "sub_text")
  final String? subText;
  @JsonKey(name: "href_text")
  final String? hrefText;
  @JsonKey(name: "button_text")
  final String? buttonText;
  @JsonKey(name: "button_link")
  final String? buttonLink;
  @JsonKey(name: "bg_color")
  final String? bgColor;
  @JsonKey(name: "text_position")
  final String? textPosition;

  factory SiteHomepageImage.fromJson(Map<String, dynamic> json) => _$SiteHomepageImageFromJson(json);

  Map<String, dynamic> toJson() => _$SiteHomepageImageToJson(this);

}