import 'package:designerwardrobe/src/features/helper/dtos/site_setting_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'site_setting_item.g.dart';

@JsonSerializable()
class SiteSettingItem {
  SiteSettingItem({
    this.success,
    this.data,
  });

  @JsonKey()
  final bool? success;
  @JsonKey()
  final SiteSettingData? data;

  factory SiteSettingItem.fromJson(Map<String, dynamic> json) =>
      _$SiteSettingItemFromJson(json);

  Map<String, dynamic> toJson() => _$SiteSettingItemToJson(this);
}
