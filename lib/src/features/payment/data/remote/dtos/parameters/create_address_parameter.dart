import 'package:json_annotation/json_annotation.dart';

part 'create_address_parameter.g.dart';

@JsonSerializable()
class CreateAddressParameter {
  @JsonKey(name: 'address_id')
  final String? addressId;

  @JsonKey(name: 'new_address_deliver_to')
  final String? newAddressDeliverTo;

  @JsonKey(name: 'allow_pickups')
  final bool? allowPickups;

  @JsonKey(name: 'new_address_company')
  final String? newAddressCompany;

  @JsonKey(name: 'new_address')
  final String? newAddress;

  CreateAddressParameter({
    this.addressId,
    this.newAddressDeliverTo,
    this.allowPickups,
    this.newAddressCompany,
    this.newAddress,
  });

  factory CreateAddressParameter.fromJson(Map<String, dynamic> json) =>
      _$CreateAddressParameterFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddressParameterToJson(this);
}