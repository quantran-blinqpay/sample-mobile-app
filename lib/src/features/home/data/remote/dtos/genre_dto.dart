import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_dto.g.dart';

@JsonSerializable()
class GenreDto extends Equatable {
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

  const GenreDto({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.code,
    this.name,
    this.v,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) => _$GenreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);

  GenreDto copyWith({
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? code,
    String? name,
    int? v,
  }) {
    return GenreDto(
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
