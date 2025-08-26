import 'package:designerwardrobe/src/features/home/domain/models/genre.dart';
import 'package:designerwardrobe/src/features/home/domain/models/movie_session.dart';
import 'type.dart';

class MovieModel {
  final List<GenreModel>? genres;
  final List<TypeModel>? types;
  final int? v;
  final String? subtitle;
  final String? language;
  final String? avatarUrl;
  final String? trailerUrl;
  final String? description;
  final int? duration;
  final String? casts;
  final String? director;
  final DateTime? endDate;
  final DateTime? startDate;
  final String? name;
  final String? slug;
  final String? id;
  final List<MovieSessionModel>? sessions;

  MovieModel(
      {required this.genres,
      required this.types,
      required this.v,
      required this.subtitle,
      required this.language,
      required this.avatarUrl,
      required this.trailerUrl,
      required this.description,
      required this.duration,
      required this.casts,
      required this.director,
      required this.endDate,
      required this.startDate,
      required this.name,
      required this.slug,
      required this.id,
      required this.sessions});
}
