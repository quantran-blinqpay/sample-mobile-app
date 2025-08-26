import 'package:json_annotation/json_annotation.dart';

part 'user_creation_parameter.g.dart';

@JsonSerializable()
class UserCreationParameter {

  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey()
  final String? email;
  @JsonKey()
  final String? username;
  @JsonKey()
  final String? password;
  @JsonKey()
  final String? gender;
  @JsonKey()
  final int? month;
  @JsonKey()
  final int? year;
  @JsonKey()
  final String? country;
  @JsonKey(name: "referred_code")
  final String? referralCode;
  @JsonKey(name: "referred_from")
  final String? referredFrom;
  @JsonKey()
  final String? city;
  @JsonKey()
  final int? terms;
  @JsonKey(name: 'sms_token')
  final String? smsToken;

  UserCreationParameter({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.password,
    this.gender,
    this.month,
    this.year,
    this.country,
    this.referralCode,
    this.referredFrom,
    this.city,
    this.terms,
    this.smsToken,
  });

  factory UserCreationParameter.fromJson(Map<String, dynamic> json) => _$UserCreationParameterFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreationParameterToJson(this);

}