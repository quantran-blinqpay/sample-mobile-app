import 'package:json_annotation/json_annotation.dart';

part 'windcave_card_response.g.dart';

@JsonSerializable()
class WindcaveCardResponse {
  final List<WindcaveCardData>? data;

  WindcaveCardResponse({this.data});

  factory WindcaveCardResponse.fromJson(Map<String, dynamic> json) =>
      _$WindcaveCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WindcaveCardResponseToJson(this);
}

@JsonSerializable()
class WindcaveCardData {
  final int? card_id;
  final String? last4;
  final String? image_url;
  final String? card_type;
  final int? expire_month;
  final int? expire_year;
  final String? card_holder_name;
  final String? token;

  WindcaveCardData({
    this.card_id,
    this.last4,
    this.image_url,
    this.card_type,
    this.expire_month,
    this.expire_year,
    this.card_holder_name,
    this.token,
  });

  factory WindcaveCardData.fromJson(Map<String, dynamic> json) =>
      _$WindcaveCardDataFromJson(json);

  Map<String, dynamic> toJson() => _$WindcaveCardDataToJson(this);
}

// {
//     "data": [
//         {
//             "card_id": 390494,
//             "last4": "1111",
//             "image_url": null,
//             "card_type": "visa",
//             "expire_month": 3,
//             "expire_year": 2027,
//             "card_holder_name": null,
//             "token": "dwca-390494"
//         }
//     ]
// }