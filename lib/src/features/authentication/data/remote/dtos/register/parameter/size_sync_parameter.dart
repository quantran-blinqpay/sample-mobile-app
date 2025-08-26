import 'package:json_annotation/json_annotation.dart';

part 'size_sync_parameter.g.dart';

@JsonSerializable()
class SizeSyncParameter {

  @JsonKey(name: 'dress_size')
  final String? dressSize;

  @JsonKey(name: 'waist_size')
  final String? waistSize;

  @JsonKey(name: 'shoe_size')
  final String? shoeSize;

  @JsonKey(name: 'sizes')
  final String? sizes;

  SizeSyncParameter({
    this.dressSize,
    this.waistSize,
    this.shoeSize,
    this.sizes,
  });

  factory SizeSyncParameter.fromJson(Map<String, dynamic> json) => _$SizeSyncParameterFromJson(json);

  Map<String, dynamic> toJson() => _$SizeSyncParameterToJson(this);

}