// {
// "status_code": 500,
// "success": false,
// "errors": {
// "referral_code": [
// "The selected referral code is invalid."
// ]
// }
// }

// {"status_code":200,"success":true}

import 'package:json_annotation/json_annotation.dart';

part 'user_validation_response.g.dart';

@JsonSerializable()
class UserValidationResponse {

  @JsonKey(name: "status_code")
  final int? statusCode;
  @JsonKey()
  final bool? success;
  @JsonKey()
  final UserValidationError? errors;

  UserValidationResponse({
    this.statusCode,
    this.success,
    this.errors,
  });

  factory UserValidationResponse.fromJson(Map<String, dynamic> json) => _$UserValidationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserValidationResponseToJson(this);

}

@JsonSerializable()
class UserValidationError {
  @JsonKey(name: "referral_code")
  final List<String>? referralCode;
  @JsonKey()
  final List<String>? username;
  @JsonKey()
  final List<String>? terms;
  @JsonKey()
  final List<String>? password;
  @JsonKey(name: 'last_name')
  final List<String>? lastName;
  @JsonKey(name: 'first_name')
  final List<String>? firstName;
  @JsonKey()
  final List<String>? email;

  UserValidationError({
    this.referralCode,
    this.username,
    this.terms,
    this.password,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory UserValidationError.fromJson(Map<String, dynamic> json) => _$UserValidationErrorFromJson(json);

  Map<String, dynamic> toJson() => _$UserValidationErrorToJson(this);
}