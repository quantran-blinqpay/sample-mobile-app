import 'package:json_annotation/json_annotation.dart';

part 'closest_town.g.dart';

@JsonSerializable()
class ClosestTown {

  @JsonKey()
  final List<String>? towns;
  @JsonKey(name: 'group_name')
  final String? groupName;

  ClosestTown({
    this.towns,
    this.groupName,
  });

  factory ClosestTown.fromJson(Map<String, dynamic> json) => _$ClosestTownFromJson(json);

  Map<String, dynamic> toJson() => _$ClosestTownToJson(this);

}