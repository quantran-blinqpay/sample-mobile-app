import 'package:qwid/src/features/filter/data/remote/dtos/filter_hits_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_search_response.g.dart';

@JsonSerializable()
class FilterSearchResponse {
  FilterSearchResponse({
    this.hits,
    this.nbHits,
    this.page,
    this.nbPages,
    this.hitsPerPage,
    this.processingTimeMS,
    this.exhaustiveNbHits,
  });

  @JsonKey()
  final List<FilterHitsDto>? hits;
  @JsonKey()
  final int? nbHits;
  @JsonKey()
  final int? page;
  @JsonKey()
  final int? nbPages;
  @JsonKey()
  final int? hitsPerPage;
  @JsonKey()
  final int? processingTimeMS;
  @JsonKey()
  final bool? exhaustiveNbHits;

  factory FilterSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterSearchResponseToJson(this);
}
