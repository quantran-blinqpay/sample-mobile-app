import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/my_address_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_address_response.g.dart';

@JsonSerializable()
class CreateAddressResponse {
  final AddressData? data;

  CreateAddressResponse({this.data});

  factory CreateAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddressResponseToJson(this);
}