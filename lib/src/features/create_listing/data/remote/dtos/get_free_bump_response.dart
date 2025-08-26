// To parse this JSON data, do
//
//     final getFreeBumpResponse = getFreeBumpResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_free_bump_response.g.dart';

GetFreeBumpResponse getFreeBumpResponseFromJson(String str) => GetFreeBumpResponse.fromJson(json.decode(str));

String getFreeBumpResponseToJson(GetFreeBumpResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetFreeBumpResponse {
    @JsonKey(name: "status_code")
    int? statusCode;
    @JsonKey(name: "available_free_bump")
    int? availableFreeBump;

    GetFreeBumpResponse({
        this.statusCode,
        this.availableFreeBump,
    });

    factory GetFreeBumpResponse.fromJson(Map<String, dynamic> json) => _$GetFreeBumpResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetFreeBumpResponseToJson(this);
}
