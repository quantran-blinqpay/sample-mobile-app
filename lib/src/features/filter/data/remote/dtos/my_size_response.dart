// To parse this JSON data, do
//
//     final mySizeResponse = mySizeResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'my_size_response.g.dart';

MySizeResponse mySizeResponseFromJson(String str) => MySizeResponse.fromJson(json.decode(str));

String mySizeResponseToJson(MySizeResponse data) => json.encode(data.toJson());

@JsonSerializable()
class MySizeResponse {
    @JsonKey(name: "data")
    List<Dat>? data;

    MySizeResponse({
        this.data,
    });

    factory MySizeResponse.fromJson(Map<String, dynamic> json) => _$MySizeResponseFromJson(json);

    Map<String, dynamic> toJson() => _$MySizeResponseToJson(this);
}

@JsonSerializable()
class StandardSize {
    @JsonKey(name: "data")
    Dat? data;

    StandardSize({
        this.data,
    });

    factory StandardSize.fromJson(Map<String, dynamic> json) => _$StandardSizeFromJson(json);

    Map<String, dynamic> toJson() => _$StandardSizeToJson(this);
}

@JsonSerializable()
class Dat {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "brand_id")
    int? brandId;
    @JsonKey(name: "size")
    String? size;
    @JsonKey(name: "standard_size_id")
    int? standardSizeId;
    @JsonKey(name: "generic_size")
    String? genericSize;
    @JsonKey(name: "alt_size")
    String? altSize;
    @JsonKey(name: "alt_size_title")
    AltSizeTitle? altSizeTitle;
    @JsonKey(name: "StandardSize")
    StandardSize? standardSize;

    Dat({
        this.id,
        this.brandId,
        this.size,
        this.standardSizeId,
        this.genericSize,
        this.altSize,
        this.altSizeTitle,
        this.standardSize,
    });

    factory Dat.fromJson(Map<String, dynamic> json) => _$DatFromJson(json);

    Map<String, dynamic> toJson() => _$DatToJson(this);
}

enum AltSizeTitle {
    @JsonValue("AU/NZ")
    AU_NZ,
    @JsonValue("")
    EMPTY,
    @JsonValue("Eur")
    EUR,
    @JsonValue("Generic")
    GENERIC
}

final altSizeTitleValues = EnumValues({
    "AU/NZ": AltSizeTitle.AU_NZ,
    "": AltSizeTitle.EMPTY,
    "Eur": AltSizeTitle.EUR,
    "Generic": AltSizeTitle.GENERIC
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
