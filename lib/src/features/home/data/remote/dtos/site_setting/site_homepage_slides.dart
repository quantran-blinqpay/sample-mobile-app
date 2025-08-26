import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/shop_by_price.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/site_homepage_image.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/top_brand.dart';
import 'package:json_annotation/json_annotation.dart';
import 'carousel.dart';

part 'site_homepage_slides.g.dart';

@JsonSerializable()
class SiteHomepageSlides {

  SiteHomepageSlides({
    this.image1,
    this.image2,
    this.image4,
  });

  @JsonKey()
  final SiteHomepageImage? image1;
  @JsonKey()
  final SiteHomepageImage? image2;
  @JsonKey()
  final SiteHomepageImage? image4;

  factory SiteHomepageSlides.fromJson(Map<String, dynamic> json) => _$SiteHomepageSlidesFromJson(json);

  Map<String, dynamic> toJson() => _$SiteHomepageSlidesToJson(this);

}