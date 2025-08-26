// To parse this JSON data, do
//
//     final getCommissionResponse = getCommissionResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_commission_response.g.dart';

GetCommissionResponse getCommissionResponseFromJson(String str) => GetCommissionResponse.fromJson(json.decode(str));

String getCommissionResponseToJson(GetCommissionResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetCommissionResponse {
    @JsonKey(name: "buyer_pays")
    double? buyerPays;
    @JsonKey(name: "seller_makes")
    double? sellerMakes;

    GetCommissionResponse({
        this.buyerPays,
        this.sellerMakes,
    });

    factory GetCommissionResponse.fromJson(Map<String, dynamic> json) => _$GetCommissionResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetCommissionResponseToJson(this);
}
