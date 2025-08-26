// To parse this JSON data, do
//
//     final currencyRateResponse = currencyRateResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'currency_rate_response.g.dart';

CurrencyRateResponse currencyRateResponseFromJson(String str) => CurrencyRateResponse.fromJson(json.decode(str));

String currencyRateResponseToJson(CurrencyRateResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CurrencyRateResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "rate_nzd_to_aud")
    double? rateNzdToAud;
    @JsonKey(name: "rate_aud_to_nzd")
    double? rateAudToNzd;

    CurrencyRateResponse({
        this.status,
        this.rateNzdToAud,
        this.rateAudToNzd,
    });

    factory CurrencyRateResponse.fromJson(Map<String, dynamic> json) => _$CurrencyRateResponseFromJson(json);

    Map<String, dynamic> toJson() => _$CurrencyRateResponseToJson(this);
}
