import 'package:json_annotation/json_annotation.dart';

part 'filter_item_response.g.dart';

@JsonSerializable()
class FilterItemResponse {
  @JsonKey()
  final int? id;
  @JsonKey()
  String? title;
  @JsonKey(name: "sub_title")
  final String? subTitle;
  @JsonKey(name: "legacy_name")
  final String? legacyName;
  @JsonKey(name: "is_active")
  final bool? isActive;

  FilterItemResponse(
      {this.id, this.title, this.subTitle, this.legacyName, this.isActive});

  factory FilterItemResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterItemResponseToJson(this);
}
