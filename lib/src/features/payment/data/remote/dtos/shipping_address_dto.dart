import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_dto.g.dart';

@JsonSerializable()
class ShippingAddressDto {
  @JsonKey()
  final int? id;
  @JsonKey()
  final String? name;
  @JsonKey()
  final String? country;
  @JsonKey()
  final String? address;

  ShippingAddressDto({this.id, this.name, this.country, this.address});

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) => _$ShippingAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressDtoToJson(this);

}