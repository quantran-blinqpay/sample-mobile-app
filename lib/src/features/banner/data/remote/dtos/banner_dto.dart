import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_dto.g.dart';

@JsonSerializable()
class BannerDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'position')
  final String? position;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'display_order')
  final int? displayOrder;
  @JsonKey(name: 'disabled')
  final bool? disabled;

  const BannerDto({
    required this.id,
    this.updatedAt,
    this.createdAt,
    this.url,
    this.position,
    this.v,
    this.displayOrder,
    this.disabled,
  });

  factory BannerDto.fromJson(Map<String, dynamic> json) {
    return _$BannerDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BannerDtoToJson(this);

  BannerDto copyWith({
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? url,
    String? position,
    int? v,
    int? displayOrder,
    bool? disabled,
  }) {
    return BannerDto(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      position: position ?? this.position,
      v: v ?? this.v,
      displayOrder: displayOrder ?? this.displayOrder,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      updatedAt,
      createdAt,
      url,
      position,
      v,
      displayOrder,
      disabled,
    ];
  }
}
