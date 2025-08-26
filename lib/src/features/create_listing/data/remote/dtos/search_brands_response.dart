// To parse this JSON data, do
//
//     final searchBrandsResponse = searchBrandsResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'search_brands_response.g.dart';

List<SearchBrandsResponse> searchBrandsResponseFromJson(String str) => List<SearchBrandsResponse>.from(json.decode(str).map((x) => SearchBrandsResponse.fromJson(x)));

String searchBrandsResponseToJson(List<SearchBrandsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class SearchBrandsResponse {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "slug")
    String? slug;
    @JsonKey(name: "annual_sales_count")
    int? annualSalesCount;
    @JsonKey(name: "is_top_sale")
    int? isTopSale;
    @JsonKey(name: "is_active")
    int? isActive;
    @JsonKey(name: "is_high_street")
    int? isHighStreet;
    @JsonKey(name: "is_valet")
    int? isValet;
    @JsonKey(name: "is_top_100")
    int? isTop100;
    @JsonKey(name: "is_popular")
    int? isPopular;
    @JsonKey(name: "popularity_score")
    int? popularityScore;
    @JsonKey(name: "sale_popularity_score")
    int? salePopularityScore;
    @JsonKey(name: "is_mens")
    int? isMens;
    @JsonKey(name: "is_beauty")
    int? isBeauty;
    @JsonKey(name: "is_womens")
    int? isWomens;
    @JsonKey(name: "is_kids")
    int? isKids;
    @JsonKey(name: "is_home")
    int? isHome;

    SearchBrandsResponse({
        this.id,
        this.name,
        this.slug,
        this.annualSalesCount,
        this.isTopSale,
        this.isActive,
        this.isHighStreet,
        this.isValet,
        this.isTop100,
        this.isPopular,
        this.popularityScore,
        this.salePopularityScore,
        this.isMens,
        this.isBeauty,
        this.isWomens,
        this.isKids,
        this.isHome,
    });

    factory SearchBrandsResponse.fromJson(Map<String, dynamic> json) => _$SearchBrandsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$SearchBrandsResponseToJson(this);
}
