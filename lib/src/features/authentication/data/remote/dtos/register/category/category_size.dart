import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/generic_size.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_size.g.dart';

@JsonSerializable()
class CategorySize {
  @JsonKey(name: 'generic_sizes')
  final List<GenericSize>? genericSizes;
  @JsonKey(name: 'url_title')
  final String? urlTitle;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'parent_id')
  final int? parentId;

  CategorySize({this.genericSizes, this.urlTitle, this.id, this.parentId});

  factory CategorySize.fromJson(Map<String, dynamic> json) =>
      _$CategorySizeFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySizeToJson(this);
}
