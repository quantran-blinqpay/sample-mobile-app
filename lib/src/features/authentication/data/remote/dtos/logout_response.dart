import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {

  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey()
  final String? message;
  @JsonKey(name: 'recombee_session_id')
  final String? recombeeSessionId;

  LogoutResponse({
    this.statusCode,
    this.message,
    this.recombeeSessionId,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => _$LogoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);

}