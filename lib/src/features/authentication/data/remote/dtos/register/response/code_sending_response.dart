import 'package:json_annotation/json_annotation.dart';

part 'code_sending_response.g.dart';

@JsonSerializable()
class CodeSendingResponse {

  @JsonKey()
  final String? status;

  @JsonKey()
  final String? message;

  CodeSendingResponse({
    this.status,
    this.message,
  });

  factory CodeSendingResponse.fromJson(Map<String, dynamic> json) => _$CodeSendingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CodeSendingResponseToJson(this);

}