import 'package:json_annotation/json_annotation.dart';

part 'lookup_address_parameter.g.dart';

@JsonSerializable()
class LookupAddressParameter {
  @JsonKey(name: 'country_code')
  final String? countryCode;

  @JsonKey()
  final String? query;

  LookupAddressParameter({this.countryCode, this.query});

  factory LookupAddressParameter.fromJson(Map<String, dynamic> json) =>
      _$LookupAddressParameterFromJson(json);

  Map<String, dynamic> toJson() => _$LookupAddressParameterToJson(this);
}