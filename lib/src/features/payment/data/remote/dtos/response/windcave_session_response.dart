import 'package:json_annotation/json_annotation.dart';

part 'windcave_session_response.g.dart';

@JsonSerializable()
class WindcaveSessionResponse {
  final String? href;
  final String? rel;
  final String? method;
  final String? currency;
  final double? amount;
  final String? sessionId;

  WindcaveSessionResponse({
    this.href,
    this.rel,
    this.method,
    this.currency,
    this.amount,
    this.sessionId,
  });

  factory WindcaveSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$WindcaveSessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WindcaveSessionResponseToJson(this);
}