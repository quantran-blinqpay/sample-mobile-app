import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_hits_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_hits_dto.g.dart';

@JsonSerializable()
class FilterHitsDto {
  FilterHitsDto({
    this.data,
  });

  @JsonKey()
  final FilterHitsResponse? data;

  factory FilterHitsDto.fromJson(Map<String, dynamic> json) =>
      _$FilterHitsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FilterHitsDtoToJson(this);
}
