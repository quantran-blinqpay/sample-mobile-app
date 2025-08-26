import 'package:json_annotation/json_annotation.dart';

part 'code_verification_response.g.dart';
// {"status":"success","message":"pass","token":"76f71d59b8518cfae70d9e6304fdd64f"}
@JsonSerializable()
class CodeVerificationResponse {

  @JsonKey()
  final String? status;

  @JsonKey()
  final String? message;

  @JsonKey()
  final String? token;

  CodeVerificationResponse({
    this.status,
    this.message,
    this.token,
  });

  factory CodeVerificationResponse.fromJson(Map<String, dynamic> json) => _$CodeVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CodeVerificationResponseToJson(this);

}