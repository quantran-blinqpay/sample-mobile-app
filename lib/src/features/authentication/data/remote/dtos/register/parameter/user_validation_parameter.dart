import 'package:json_annotation/json_annotation.dart';

part 'user_validation_parameter.g.dart';

@JsonSerializable()
class UserValidationParameter {

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
  @JsonKey(name: "facebook_id")
  final String? facebookId;
  @JsonKey(name: "facebook_token")
  final String? facebookToken;
  @JsonKey(name: "apple_token")
  final String? appleToken;
  @JsonKey(name: "sell_later_token")
  final String? sellLaterToken;
  @JsonKey()
  final List<String>? categories;

  UserValidationParameter({
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
    this.facebookId,
    this.facebookToken,
    this.appleToken,
    this.sellLaterToken,
    this.categories,
  });

  factory UserValidationParameter.fromJson(Map<String, dynamic> json) => _$UserValidationParameterFromJson(json);

  Map<String, dynamic> toJson() => _$UserValidationParameterToJson(this);

}