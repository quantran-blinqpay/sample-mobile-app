import 'package:qwid/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carousel.g.dart';

@JsonSerializable()
class Carousel {

  Carousel({
    this.image,
    this.url,
  });

  @JsonKey()
  final String? image;
  @JsonKey()
  final String? url;

  factory Carousel.fromJson(Map<String, dynamic> json) => _$CarouselFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselToJson(this);

}