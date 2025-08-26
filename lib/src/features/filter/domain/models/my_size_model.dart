// To parse this JSON data, do
//
//     final mySizeModel = mySizeModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'my_size_model.g.dart';

MySizeModel mySizeModelFromJson(String str) => MySizeModel.fromJson(json.decode(str));

String mySizeModelToJson(MySizeModel data) => json.encode(data.toJson());

@JsonSerializable()
class MySizeModel {
    @JsonKey(name: "dress_size")
    String? dressSize;
    @JsonKey(name: "waist_size")
    String? waistSize;
    @JsonKey(name: "shoe_size")
    String? shoeSize;
    @JsonKey(name: "sizes")
    String? sizes;

    MySizeModel({
        this.dressSize,
        this.waistSize,
        this.shoeSize,
        this.sizes,
    });

    factory MySizeModel.fromJson(Map<String, dynamic> json) => _$MySizeModelFromJson(json);

    Map<String, dynamic> toJson() => _$MySizeModelToJson(this);
}
