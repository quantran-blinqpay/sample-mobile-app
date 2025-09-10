import 'package:qwid/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {

  CategoryEntity({
    this.categoryName,
    this.image,
    this.categoryId,
  });

  @JsonKey(name: "category_name")
  final String? categoryName;
  @JsonKey()
  final String? image;
  @JsonKey(name: "category_id")
  final int? categoryId;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

}