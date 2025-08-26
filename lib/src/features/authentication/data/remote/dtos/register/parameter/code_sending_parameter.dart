import 'package:json_annotation/json_annotation.dart';

part 'code_sending_parameter.g.dart';

@JsonSerializable()
class CodeSendingParameter {

  @JsonKey()
  final String? country;
  @JsonKey()
  final String? phone;
  @JsonKey(name: "task_slug")
  final String? taskSlug;
  @JsonKey(name: "second_param")
  final String? secondParam;

  CodeSendingParameter({
    this.phone,
    this.taskSlug,
    this.country,
    this.secondParam,
  });

  factory CodeSendingParameter.fromJson(Map<String, dynamic> json) => _$CodeSendingParameterFromJson(json);

  Map<String, dynamic> toJson() => _$CodeSendingParameterToJson(this);

}