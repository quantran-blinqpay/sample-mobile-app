// To parse this JSON data, do
//
//     final uploadImageResponse = uploadImageResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'upload_image_response.g.dart';

UploadImageResponse uploadImageResponseFromJson(String str) => UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) => json.encode(data.toJson());

@JsonSerializable()
class UploadImageResponse {
    @JsonKey(name: "thumbnail")
    String? thumbnail;
    @JsonKey(name: "url")
    String? url;
    @JsonKey(name: "status_code")
    int? statusCode;
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "delete_url")
    String? deleteUrl;
    @JsonKey(name: "rotate_url")
    String? rotateUrl;

    UploadImageResponse({
        this.thumbnail,
        this.url,
        this.statusCode,
        this.id,
        this.deleteUrl,
        this.rotateUrl,
    });

    factory UploadImageResponse.fromJson(Map<String, dynamic> json) => _$UploadImageResponseFromJson(json);

    Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}
