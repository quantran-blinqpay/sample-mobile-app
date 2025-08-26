import 'package:json_annotation/json_annotation.dart';

part 'batch_update_frequency_response.g.dart';

@JsonSerializable()
class BatchUpdateFrequencyResponse {

  @JsonKey()
  final bool? success;

  BatchUpdateFrequencyResponse({
    this.success,
  });

  factory BatchUpdateFrequencyResponse.fromJson(Map<String, dynamic> json) => _$BatchUpdateFrequencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchUpdateFrequencyResponseToJson(this);

}