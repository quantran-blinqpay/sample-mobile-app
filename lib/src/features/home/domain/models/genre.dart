import 'dart:convert';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final String? id;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String? code;
  final String? name;

  const GenreModel({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.code,
    this.name,
  });

  factory GenreModel.fromMap(Map<String, dynamic> data) => GenreModel(
        id: data['_id'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        code: data['code'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'code': code,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GenreModel].
  factory GenreModel.fromJson(String data) {
    return GenreModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GenreModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GenreModel copyWith({
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? code,
    String? name,
  }) {
    return GenreModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, updatedAt, createdAt, code, name];
}
