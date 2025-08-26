import 'package:json_annotation/json_annotation.dart';

part 'windcave_session_parameter.g.dart';

@JsonSerializable()
class WindcaveSessionParameter {
  final double amount;
  final String currency;

  WindcaveSessionParameter({
    required this.amount,
    required this.currency,
  });

  factory WindcaveSessionParameter.fromJson(Map<String, dynamic> json) =>
      _$WindcaveSessionParameterFromJson(json);

  Map<String, dynamic> toJson() => _$WindcaveSessionParameterToJson(this);
}