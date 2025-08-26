import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_brands_response.g.dart';

GetBrandsResponse getStartupResponseFromJson(String str) =>
    GetBrandsResponse.fromJson(json.decode(str));

String getStartupResponseToJson(GetBrandsResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetBrandsResponse {
  @JsonKey(name: "women")
  BeautyWellness? women;
  @JsonKey(name: "men")
  BeautyWellness? men;
  @JsonKey(name: "beauty-wellness")
  BeautyWellness? beautyWellness;
  @JsonKey(name: "home")
  Home? home;
  @JsonKey(name: "kids")
  Home? kids;
  @JsonKey(name: "cache_key_time")
  String? cacheKeyTime;

  GetBrandsResponse({
    this.women,
    this.men,
    this.beautyWellness,
    this.home,
    this.kids,
    this.cacheKeyTime,
  });

  factory GetBrandsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBrandsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBrandsResponseToJson(this);
}

@JsonSerializable()
class BeautyWellness {
  @JsonKey(name: "data")
  List<BeautyWellnessDatum>? data;

  BeautyWellness({
    this.data,
  });

  factory BeautyWellness.fromJson(Map<String, dynamic> json) =>
      _$BeautyWellnessFromJson(json);

  Map<String, dynamic> toJson() => _$BeautyWellnessToJson(this);
}

@JsonSerializable()
class BeautyWellnessDatum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url_title")
  String? urlTitle;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_top_rental")
  int? isTopRental;
  @JsonKey(name: "is_top_sale")
  int? isTopSale;
  @JsonKey(name: "popularity_score")
  int? popularityScore;

  BeautyWellnessDatum({
    this.id,
    this.title,
    this.urlTitle,
    this.description,
    this.isTopRental,
    this.isTopSale,
    this.popularityScore,
  });

  factory BeautyWellnessDatum.fromJson(Map<String, dynamic> json) =>
      _$BeautyWellnessDatumFromJson(json);

  Map<String, dynamic> toJson() => _$BeautyWellnessDatumToJson(this);
}

@JsonSerializable()
class Home {
  @JsonKey(name: "data")
  List<BeautyWellnessDatum>? data;

  Home({
    this.data,
  });

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
