import 'package:json_annotation/json_annotation.dart';
import 'package:designerwardrobe/src/core/network/response/error/error_entity.dart';

part 'array_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ArrayResponse<T> {
  @JsonKey(defaultValue: "")
  final String message;
  @JsonKey(defaultValue: -1)
  final int code;
  @JsonKey(defaultValue: [])
  final List<T> data;
  @JsonKey(defaultValue: "")
  final String token;
  @JsonKey()
  final List<ErrorEntity> errors;
  @JsonKey()
  final double expiresIn;

  ArrayResponse(
      {this.message = "",
      this.code = -1,
      this.expiresIn = -1,
      this.token = '',
      this.data = const [],
      this.errors = const []});

  factory ArrayResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ArrayResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ArrayResponseToJson(this, toJsonT);
}
