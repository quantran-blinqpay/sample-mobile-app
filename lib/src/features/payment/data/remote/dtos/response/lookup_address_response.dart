import 'package:json_annotation/json_annotation.dart';

part 'lookup_address_response.g.dart';

@JsonSerializable()
class LookupAddressResponse {
  @JsonKey()
  final bool? success;

  @JsonKey()
  final List<AddressItem>? addresses;

  LookupAddressResponse({this.success, this.addresses});

  factory LookupAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$LookupAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LookupAddressResponseToJson(this);
}

@JsonSerializable()
class AddressItem {
  @JsonKey(name: 'full_address')
  final String? fullAddress;

  @JsonKey(name: 'address_id')
  final String? addressId;

  @JsonKey()
  final String? dpid;

  AddressItem({this.fullAddress, this.addressId, this.dpid});

  factory AddressItem.fromJson(Map<String, dynamic> json) =>
      _$AddressItemFromJson(json);

  Map<String, dynamic> toJson() => _$AddressItemToJson(this);
}