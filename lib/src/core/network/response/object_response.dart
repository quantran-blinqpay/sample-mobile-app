import 'package:json_annotation/json_annotation.dart';
import 'package:qwid/src/core/network/response/error/error_entity.dart';

part 'object_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ObjectResponse<T> {
  @JsonKey(defaultValue: -1)
  final int code;
  @JsonKey(defaultValue: "")
  final String message;
  @JsonKey(defaultValue: "")
  final String token;
  @JsonKey()
  final List<ErrorEntity> errors;
  @JsonKey()
  final T? data;
  @JsonKey()
  final double expiresIn;

  ObjectResponse(
      {this.code = -1,
      this.message = '',
      this.data,
      this.token = '',
      this.expiresIn = -1,
      this.errors = const []});

  factory ObjectResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ObjectResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ObjectResponseToJson(this, toJsonT);
}
