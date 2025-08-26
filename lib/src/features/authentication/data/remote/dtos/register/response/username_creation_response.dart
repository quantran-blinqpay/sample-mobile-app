import 'package:json_annotation/json_annotation.dart';

part 'username_creation_response.g.dart';

@JsonSerializable()
class UsernameCreationResponse {

  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey()
  final String? token;
  @JsonKey()
  final int? id;

  UsernameCreationResponse({
    this.statusCode,
    this.token,
    this.id,
  });

  factory UsernameCreationResponse.fromJson(Map<String, dynamic> json) => _$UsernameCreationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameCreationResponseToJson(this);

}