import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'default_response.g.dart';

DefaultResponse defaultResponseFromJson(String str) =>
    DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class DefaultResponse {
  @JsonKey(name: "status_code")
  int? statusCode;
  @JsonKey(name: "message")
  String? message;

  DefaultResponse({
    this.statusCode,
    this.message,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      _$DefaultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultResponseToJson(this);
}
