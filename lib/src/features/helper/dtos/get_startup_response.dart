import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/get_category_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/get_colour_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/get_condition_response.dart';
import 'package:qwid/src/features/home/data/remote/dtos/brand_catalog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_startup_response.g.dart';

@JsonSerializable()
class GetStartupResponse {
  GetStartupResponse({
    this.colours,
    this.conditions,
    this.brands,
    this.categories,
  });

  @JsonKey()
  final BrandCatalog? brands;
  @JsonKey()
  final GetColourResponse? colours;
  @JsonKey()
  final GetConditionResponse? conditions;
  @JsonKey()
  final List<GetCategoryResponse>? categories;

  factory GetStartupResponse.fromJson(Map<String, dynamic> json) =>
      _$GetStartupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetStartupResponseToJson(this);

  bool haveChidren(int id) {
    return categories?.any((e) => e.parentId == id) ?? false;
  }

  List<FilterClass> toCategoriesItemList({int? parentId}) {
    if (categories == null) return [];

    final List<FilterClass> result = [];
    final parentCate =
        categories!.where((e) => e.parentId == parentId).toList();
    for (final item in parentCate) {
      final id = item.id;
      final title = item.title;
      final parentId = item.parentId;
      final urlTitle = item.urlTitle;
      if (id != null && title != null && title.trim().isNotEmpty) {
        result.add(FilterClass(
          id: id.toString(),
          name: title,
          parentId: parentId,
          urlTitle: urlTitle,
        ));
      }
    }
    return result;
  }
}
