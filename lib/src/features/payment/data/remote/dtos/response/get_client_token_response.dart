import 'package:json_annotation/json_annotation.dart';

part 'get_client_token_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetClientTokenResponse {
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final String? message;
  @JsonKey(name: 'client_token')
  final String? clientToken;

  GetClientTokenResponse({
    this.statusCode,
    this.message,
    this.clientToken,
  });

  factory GetClientTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$GetClientTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetClientTokenResponseToJson(this);
}