import 'package:qwid/src/features/authentication/data/remote/dtos/register/category/category_size.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_size_response.g.dart';

@JsonSerializable()
class CategorySizeResponse {
  @JsonKey(name: 'categories')
  final List<CategorySize>? categories;

  CategorySizeResponse({this.categories});

  factory CategorySizeResponse.fromJson(Map<String, dynamic> json) =>
      _$CategorySizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySizeResponseToJson(this);
}
