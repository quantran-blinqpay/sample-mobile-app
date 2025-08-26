import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_size_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_category_response.g.dart';

@JsonSerializable()
class GetCategoryResponse {
  @JsonKey()
  final int? id;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey()
  final String? title;
  @JsonKey(name: 'url_title')
  final String? urlTitle;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: 'is_rental')
  final int? isRental;
  @JsonKey(name: 'can_multi_select')
  final int? canMultiSelect;
  @JsonKey(name: 'accepts_listings')
  final int? acceptsListings;
  @JsonKey(name: 'shipping_option_id')
  final int? shippingOptionId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: '_lft')
  final int? iLft;
  @JsonKey(name: '_rgt')
  final int? iRgt;
  @JsonKey(name: 'generic_sizes')
  final List<FilterSizeResponse>? genericSizes;

  GetCategoryResponse({
    this.id,
    this.parentId,
    this.title,
    this.urlTitle,
    this.isActive,
    this.isRental,
    this.canMultiSelect,
    this.acceptsListings,
    this.shippingOptionId,
    this.createdAt,
    this.updatedAt,
    this.iLft,
    this.iRgt,
    this.genericSizes,
  });

  factory GetCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoryResponseToJson(this);
}
