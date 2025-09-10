import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/home/data/remote/dtos/brand_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brands_by_category.g.dart';

@JsonSerializable()
class BrandsByCategory {
  BrandsByCategory({this.data});

  final List<BrandItem?>? data;

  factory BrandsByCategory.fromJson(Map<String, dynamic> json) =>
      _$BrandsByCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BrandsByCategoryToJson(this);

  List<FilterClass> toBrandItemList() {
    if (data == null) return [];

    final List<FilterClass> result = [];
    for (final item in data!) {
      final id = item?.id;
      final title = item?.title;
      final urlTitle = item?.urlTitle;
      if (id != null && title != null && title.trim().isNotEmpty) {
        result.add(FilterClass(
          id: id.toString(),
          name: title,
          urlTitle: urlTitle,
        ));
      }
    }
    return result;
  }
}
