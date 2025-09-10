import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_condition_response.g.dart';

@JsonSerializable()
class GetConditionResponse {
  GetConditionResponse({
    this.data,
  });

  @JsonKey()
  final List<FilterItemResponse>? data;

  factory GetConditionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetConditionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetConditionResponseToJson(this);

  List<FilterClass> toConditionItemList() {
    if (data == null) return [];

    final List<FilterClass> result = [];
    for (final item in data!) {
      final id = item.id;
      final title = item.title;
      final subTitle = item.subTitle;
      if (id != null && title != null && title.trim().isNotEmpty) {
        result.add(FilterClass(
          id: id.toString(),
          name: title,
          subName: subTitle,
        ));
      }
    }
    return result;
  }
}
