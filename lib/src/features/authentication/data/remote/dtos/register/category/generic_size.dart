import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_size.g.dart';

// "id": 23,
// "brand_id": null,
// "standard_size_id": null,
// "is_active": 1,
// "generic_size": "4",
// "alt_size": "XXS",
// "alt_size_title": "Generic",
// "pivot": {
//   "category_id": 11,
//   "size_id": 23
// },
@JsonSerializable()
class GenericSize extends Equatable{
  @JsonKey()
  final int? id;
  @JsonKey(name: 'is_active')
  final int? isActive;
  @JsonKey(name: 'generic_size')
  final String? genericSize;
  @JsonKey(name: 'alt_size')
  final String? altSize;
  @JsonKey(name: 'alt_size_title')
  final String? altSizeTitle;

  const GenericSize(
      {this.id,
      this.isActive,
      this.genericSize,
      this.altSize,
      this.altSizeTitle});

  factory GenericSize.fromJson(Map<String, dynamic> json) =>
      _$GenericSizeFromJson(json);

  Map<String, dynamic> toJson() => _$GenericSizeToJson(this);

  @override
  List<Object?> get props => [
    id,
    isActive,
    genericSize,
    altSize,
    altSizeTitle];
}
