import 'package:json_annotation/json_annotation.dart';

part 'my_address_response.g.dart';

@JsonSerializable()
class MyAddressResponse {
  final List<AddressData>? data;

  MyAddressResponse({this.data});

  factory MyAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$MyAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyAddressResponseToJson(this);
}

@JsonSerializable()
class AddressData {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'address_id')
  final int? addressId;
  @JsonKey(name: 'deliver_to')
  final String? deliverTo;
  final String? company;
  final String? street;
  final String? suburb;
  final String? city;
  final String? postcode;
  final String? country;
  @JsonKey(name: 'default')
  final bool? isDefault;
  @JsonKey(name: 'allow_pickups')
  final bool? allowPickups;
  @JsonKey(name: 'is_rural_delivery')
  final bool? isRuralDelivery;
  final double? longitude;
  final double? latitude;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  AddressData({
    this.id,
    this.userId,
    this.addressId,
    this.deliverTo,
    this.company,
    this.street,
    this.suburb,
    this.city,
    this.postcode,
    this.country,
    this.isDefault,
    this.allowPickups,
    this.isRuralDelivery,
    this.longitude,
    this.latitude,
    this.createdAt,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}

// {
//     "data": [
//         {
//             "id": 181955,
//             "user_id": 215161,
//             "address_id": 1593455,
//             "deliver_to": "Tin 1",
//             "company": null,
//             "street": "123 Abbot Street",
//             "suburb": "Waverley",
//             "city": "Invercargill",
//             "postcode": "9810",
//             "country": "New Zealand",
//             "default": true,
//             "allow_pickups": false,
//             "is_rural_delivery": false,
//             "longitude": null,
//             "latitude": null,
//             "created_at": "2022-07-14 20:59:38"
//         },
//         {
//             "id": 266789,
//             "user_id": 215161,
//             "address_id": 2334166,
//             "deliver_to": "Tin 2",
//             "company": null,
//             "street": "123 Babich Road North",
//             "suburb": "Ranui",
//             "city": "Auckland",
//             "postcode": "0612",
//             "country": "New Zealand",
//             "default": false,
//             "allow_pickups": false,
//             "is_rural_delivery": false,
//             "longitude": null,
//             "latitude": null,
//             "created_at": "2024-06-18 21:26:20"
//         }
//     ]
// }