import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_dwpost_freight_response.g.dart';

GetDwpostFreightResponse dwpostFreightResponseFromJson(String str) =>
    GetDwpostFreightResponse.fromJson(json.decode(str));

String dwpostFreightResponseToJson(GetDwpostFreightResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetDwpostFreightResponse {
  @JsonKey(name: "nz_to_nz")
  List<NzTo>? nzToNz;
  @JsonKey(name: "nz_to_au")
  List<NzTo>? nzToAu;

  GetDwpostFreightResponse({
    this.nzToNz,
    this.nzToAu,
  });

  factory GetDwpostFreightResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDwpostFreightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDwpostFreightResponseToJson(this);
}

@JsonSerializable()
class NzTo {
  @JsonKey(name: "size")
  String? size;
  @JsonKey(name: "price")
  double? price;

  NzTo({
    this.size,
    this.price,
  });

  factory NzTo.fromJson(Map<String, dynamic> json) => _$NzToFromJson(json);

  Map<String, dynamic> toJson() => _$NzToToJson(this);
}
