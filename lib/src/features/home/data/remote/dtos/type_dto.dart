import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_dto.g.dart';

@JsonSerializable()
class TypeDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String? code;
  final String? name;
  @JsonKey(name: '__v')
  final int? v;

  const TypeDto({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.code,
    this.name,
    this.v,
  });

  factory TypeDto.fromJson(Map<String, dynamic> json) => _$TypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TypeDtoToJson(this);

  TypeDto copyWith({
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? code,
    String? name,
    int? v,
  }) {
    return TypeDto(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      code: code ?? this.code,
      name: name ?? this.name,
      v: v ?? this.v,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, updatedAt, createdAt, code, name, v];
}
