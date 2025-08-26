import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'genre_dto.dart';
import 'movie_session_dto.dart';
import 'type_dto.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto extends Equatable {
  final List<GenreDto>? genres;
  final List<TypeDto>? types;
  @JsonKey(name: '__v')
  final int? v;
  final String? subtitle;
  final String? language;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'trailer_url')
  final String? trailerUrl;
  final String? description;
  final int? duration;
  final String? casts;
  final String? director;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  final String? name;
  final String? slug;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'sessions')
  final List<MovieSessionDto>? sessions;

  const MovieDto({
    this.genres,
    this.types,
    this.v,
    this.subtitle,
    this.language,
    this.avatarUrl,
    this.trailerUrl,
    this.description,
    this.duration,
    this.casts,
    this.director,
    this.endDate,
    this.startDate,
    this.name,
    this.slug,
    this.id,
    this.sessions,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return _$MovieDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  MovieDto copyWith({
    List<GenreDto>? genres,
    List<TypeDto>? types,
    int? v,
    String? subtitle,
    String? language,
    String? avatarUrl,
    String? trailerUrl,
    String? description,
    int? duration,
    String? casts,
    String? director,
    DateTime? endDate,
    DateTime? startDate,
    String? name,
    String? slug,
    String? id,
    List<MovieSessionDto>? sessions,
  }) {
    return MovieDto(
      genres: genres ?? this.genres,
      types: types ?? this.types,
      v: v ?? this.v,
      subtitle: subtitle ?? this.subtitle,
      language: language ?? this.language,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      casts: casts ?? this.casts,
      director: director ?? this.director,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      id: id ?? this.id,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      genres,
      types,
      v,
      subtitle,
      language,
      avatarUrl,
      trailerUrl,
      description,
      duration,
      casts,
      director,
      endDate,
      startDate,
      name,
      slug,
      id,
      sessions,
    ];
  }
}
