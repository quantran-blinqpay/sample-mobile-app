import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDto {

  @JsonKey()
  final int? id;
  @JsonKey()
  final String? title;
  @JsonKey()
  final String? subtitle;
  @JsonKey()
  final String? size;
  @JsonKey()
  final double? discountPrice;
  @JsonKey()
  final double? price;
  @JsonKey()
  final String? image;
  @JsonKey()
  final int? discountPercent;


  OrderItemDto({this.id, this.title, this.subtitle, this.size,
    this.discountPrice, this.price, this.image, this.discountPercent});

  factory OrderItemDto.fromJson(Map<String, dynamic> json) => _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);

}