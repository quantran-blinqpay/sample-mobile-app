import 'package:json_annotation/json_annotation.dart';

part 'filter_size_response.g.dart';

@JsonSerializable()
class FilterSizeResponse {
  @JsonKey()
  final int? id;
  @JsonKey(name: '')
  final int? brandId;
   @JsonKey(name: 'standard_size_id')
  final int? standardSizeId;
   @JsonKey(name: 'is_active')
  final int? isActive;
   @JsonKey(name: 'generic_size')
  final String? genericSize;
   @JsonKey(name: 'alt_size')
  final String? altSize;
   @JsonKey(name: 'alt_size_title')
  final String? altSizeTitle;

  FilterSizeResponse({
    this.id,
    this.brandId,
    this.standardSizeId,
    this.isActive,
    this.genericSize,
    this.altSize,
    this.altSizeTitle,
  });

  factory FilterSizeResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterSizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterSizeResponseToJson(this);
}
