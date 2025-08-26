// To parse this JSON data, do
//
//     final buildDescByAiResponse = buildDescByAiResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'build_desc_by_ai_response.g.dart';

BuildDescByAiResponse buildDescByAiResponseFromJson(String str) => BuildDescByAiResponse.fromJson(json.decode(str));

String buildDescByAiResponseToJson(BuildDescByAiResponse data) => json.encode(data.toJson());

@JsonSerializable()
class BuildDescByAiResponse {
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "colour")
    List<String>? colour;
    @JsonKey(name: "category")
    String? category;
    @JsonKey(name: "condition")
    String? condition;
    @JsonKey(name: "brand")
    String? brand;
    @JsonKey(name: "size")
    String? size;
    @JsonKey(name: "original price")
    double? originalPrice;
    @JsonKey(name: "build-time")
    int? buildTime;

    BuildDescByAiResponse({
        this.title,
        this.description,
        this.colour,
        this.category,
        this.condition,
        this.brand,
        this.size,
        this.originalPrice,
        this.buildTime,
    });

    factory BuildDescByAiResponse.fromJson(Map<String, dynamic> json) => _$BuildDescByAiResponseFromJson(json);

    Map<String, dynamic> toJson() => _$BuildDescByAiResponseToJson(this);
}
