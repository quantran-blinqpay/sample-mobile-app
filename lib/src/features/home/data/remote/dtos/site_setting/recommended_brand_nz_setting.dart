import 'package:qwid/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/shop_by_price.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/top_brand.dart';
import 'package:json_annotation/json_annotation.dart';
import 'carousel.dart';

part 'recommended_brand_nz_setting.g.dart';

@JsonSerializable()
class RecommendedBrandNZSetting {

  @JsonKey(name: "1")
  final String? item1;
  @JsonKey(name: "2")
  final String? item2;
  @JsonKey(name: "3")
  final String? item3;
  @JsonKey(name: "4")
  final String? item4;
  @JsonKey(name: "5")
  final String? item5;
  @JsonKey(name: "6")
  final String? item6;
  @JsonKey(name: "7")
  final String? item7;
  @JsonKey(name: "8")
  final String? item8;
  @JsonKey(name: "9")
  final String? item9;
  @JsonKey(name: "10")
  final String? item10;
  @JsonKey(name: "11")
  final String? item11;
  @JsonKey(name: "12")
  final String? item12;
  @JsonKey(name: "13")
  final String? item13;
  @JsonKey(name: "14")
  final String? item14;
  @JsonKey(name: "15")
  final String? item15;
  @JsonKey(name: "16")
  final String? item16;
  @JsonKey(name: "17")
  final String? item17;
  @JsonKey(name: "18")
  final String? item18;
  @JsonKey(name: "19")
  final String? item19;
  @JsonKey(name: "20")
  final String? item20;
  @JsonKey(name: "21")
  final String? item21;
  @JsonKey(name: "22")
  final String? item22;
  @JsonKey(name: "23")
  final String? item23;
  @JsonKey(name: "24")
  final String? item24;
  @JsonKey(name: "25")
  final String? item25;
  @JsonKey(name: "26")
  final String? item26;
  @JsonKey(name: "27")
  final String? item27;
  @JsonKey(name: "28")
  final String? item28;
  @JsonKey(name: "29")
  final String? item29;
  @JsonKey(name: "30")
  final String? item30;
  @JsonKey(name: "31")
  final String? item31;

  factory RecommendedBrandNZSetting.fromJson(Map<String, dynamic> json) => _$RecommendedBrandNZSettingFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedBrandNZSettingToJson(this);

  const RecommendedBrandNZSetting({
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
    this.item6,
    this.item7,
    this.item8,
    this.item9,
    this.item10,
    this.item11,
    this.item12,
    this.item13,
    this.item14,
    this.item15,
    this.item16,
    this.item17,
    this.item18,
    this.item19,
    this.item20,
    this.item21,
    this.item22,
    this.item23,
    this.item24,
    this.item25,
    this.item26,
    this.item27,
    this.item28,
    this.item29,
    this.item30,
    this.item31,
  });
}