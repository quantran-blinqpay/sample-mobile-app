import 'package:designerwardrobe/src/features/authentication/presentation/views/register/register_screen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'batch_update_frequency_parameter.g.dart';

@JsonSerializable()
class BatchUpdateFrequencyParameter {

  @JsonKey()
  final List<int>? ids;
  @JsonKey()
  final String? frequency;

  BatchUpdateFrequencyParameter({
    this.ids,
    this.frequency,
  });

  factory BatchUpdateFrequencyParameter.fromJson(Map<String, dynamic> json) => _$BatchUpdateFrequencyParameterFromJson(json);

  Map<String, dynamic> toJson() => _$BatchUpdateFrequencyParameterToJson(this);

}

@JsonSerializable()
class BrandTag {
  final int idx;
  final String id;
  final String name;

  BrandTag({required this.idx, required this.id, required this.name});

  factory BrandTag.fromJson(Map<String, dynamic> json) => _$BrandTagFromJson(json);

  Map<String, dynamic> toJson() => _$BrandTagToJson(this);
}