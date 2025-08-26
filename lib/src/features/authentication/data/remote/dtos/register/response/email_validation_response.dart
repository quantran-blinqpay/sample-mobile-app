import 'package:json_annotation/json_annotation.dart';

part 'email_validation_response.g.dart';

@JsonSerializable()
class EmailValidationResponse {

  @JsonKey()
  final bool? status;

  EmailValidationResponse({
    this.status,
  });

  factory EmailValidationResponse.fromJson(Map<String, dynamic> json) => _$EmailValidationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailValidationResponseToJson(this);

}