import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/brand_following.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/category_size.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_following_response.g.dart';

@JsonSerializable()
class BrandFollowingResponse {
  @JsonKey()
  final List<BrandFollowing>? data;

  BrandFollowingResponse({this.data});

  factory BrandFollowingResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandFollowingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BrandFollowingResponseToJson(this);
}
