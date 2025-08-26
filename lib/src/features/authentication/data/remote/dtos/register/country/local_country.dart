import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/country/closest_town.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_country.g.dart';

@JsonSerializable()
class LocalCountry {

  @JsonKey(name: 'closest_towns')
  final List<ClosestTown>? closestTowns;
  @JsonKey(name: 'country_name')
  final String? countryName;
  @JsonKey()
  final int? idx;
  @JsonKey()
  final String? flag;
  @JsonKey(name: 'phone_code')
  final String? phoneCode;

  LocalCountry({
    this.closestTowns,
    this.countryName,
    this.idx,
    this.flag,
    this.phoneCode,
  });

  factory LocalCountry.fromJson(Map<String, dynamic> json) => _$LocalCountryFromJson(json);

  Map<String, dynamic> toJson() => _$LocalCountryToJson(this);

}