import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {

  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey()
  final String? token;
  @JsonKey()
  final int? id;
  @JsonKey(name: 'is_admin')
  final bool? isAdmin;

  LoginResponse({
    this.statusCode,
    this.token,
    this.id,
    this.isAdmin,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}