import 'package:json_annotation/json_annotation.dart';

part 'brand_following_parameter.g.dart';

@JsonSerializable()
class BrandFollowingParameter {

  @JsonKey(name: "brand_ids")
  final String? brandIds;

  BrandFollowingParameter({
    this.brandIds,
  });

  factory BrandFollowingParameter.fromJson(Map<String, dynamic> json) => _$BrandFollowingParameterFromJson(json);

  Map<String, dynamic> toJson() => _$BrandFollowingParameterToJson(this);

}