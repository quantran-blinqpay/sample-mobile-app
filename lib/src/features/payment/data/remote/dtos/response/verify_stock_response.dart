import 'package:json_annotation/json_annotation.dart';

part 'verify_stock_response.g.dart';

@JsonSerializable()
class VerifyStockResponse {
  final int? status;
  final bool? in_stock;
  final bool? is_dw_store;

  VerifyStockResponse({
    this.status,
    this.in_stock,
    this.is_dw_store,
  });

  factory VerifyStockResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyStockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyStockResponseToJson(this);
}

