import 'package:json_annotation/json_annotation.dart';

part 'size_sync_response.g.dart';

@JsonSerializable()
class SizeSyncResponse {

  @JsonKey()
  final List<SizeSyncData>? data;

  SizeSyncResponse({
    this.data,
  });

  factory SizeSyncResponse.fromJson(Map<String, dynamic> json) => _$SizeSyncResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SizeSyncResponseToJson(this);

}

@JsonSerializable()
class SizeSyncData {

  @JsonKey()
  final int? id;
  @JsonKey(name: "brand_id")
  final int? brandId;
  @JsonKey()
  final String? size;
  @JsonKey(name: "standard_size_id")
  final int? standardSizeId;
  @JsonKey(name: "generic_size")
  final String? genericSize;
  @JsonKey(name: "alt_size")
  final String? altSize;
  @JsonKey(name: "alt_size_title")
  final String? altSizeTitle;

  SizeSyncData({
    this.id,
    this.brandId,
    this.size,
    this.standardSizeId,
    this.genericSize,
    this.altSize,
    this.altSizeTitle,
  });

  factory SizeSyncData.fromJson(Map<String, dynamic> json) => _$SizeSyncDataFromJson(json);

  Map<String, dynamic> toJson() => _$SizeSyncDataToJson(this);

}