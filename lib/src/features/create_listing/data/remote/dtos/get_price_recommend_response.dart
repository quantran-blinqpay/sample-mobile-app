// To parse this JSON data, do
//
//     final getPriceRecommendResponse = getPriceRecommendResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_price_recommend_response.g.dart';

GetPriceRecommendResponse getPriceRecommendResponseFromJson(String str) => GetPriceRecommendResponse.fromJson(json.decode(str));

String getPriceRecommendResponseToJson(GetPriceRecommendResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetPriceRecommendResponse {
    @JsonKey(name: "success")
    bool? success;
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "prices")
    Prices? prices;

    GetPriceRecommendResponse({
        this.success,
        this.message,
        this.prices,
    });

    factory GetPriceRecommendResponse.fromJson(Map<String, dynamic> json) => _$GetPriceRecommendResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetPriceRecommendResponseToJson(this);
}

@JsonSerializable()
class Prices {
    @JsonKey(name: "min")
    int? min;
    @JsonKey(name: "max")
    int? max;
    @JsonKey(name: "median")
    double? median;

    Prices({
        this.min,
        this.max,
        this.median,
    });

    factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);

    Map<String, dynamic> toJson() => _$PricesToJson(this);
}
