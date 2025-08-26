import 'package:json_annotation/json_annotation.dart';

part 'code_verification_parameter.g.dart';

@JsonSerializable()
class CodeVerificationParameter {

  @JsonKey()
  final String? otp;
  @JsonKey()
  final String? phone;
  @JsonKey(name: "task_slug")
  final String? taskSlug;
  @JsonKey(name: "second_param")
  final String? secondParam;

  CodeVerificationParameter({
    this.phone,
    this.taskSlug,
    this.otp,
    this.secondParam,
  });

  factory CodeVerificationParameter.fromJson(Map<String, dynamic> json) => _$CodeVerificationParameterFromJson(json);

  Map<String, dynamic> toJson() => _$CodeVerificationParameterToJson(this);

}