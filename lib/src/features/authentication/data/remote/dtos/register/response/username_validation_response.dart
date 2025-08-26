import 'package:json_annotation/json_annotation.dart';

part 'username_validation_response.g.dart';

@JsonSerializable()
class UsernameValidationResponse {

  @JsonKey()
  final bool? status;

  UsernameValidationResponse({
    this.status,
  });

  factory UsernameValidationResponse.fromJson(Map<String, dynamic> json) => _$UsernameValidationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameValidationResponseToJson(this);

}