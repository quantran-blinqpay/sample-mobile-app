import 'package:qwid/src/features/home/data/remote/dtos/movie_dto.dart';
import 'package:qwid/src/features/home/domain/models/genre_mapper.dart';
import 'package:qwid/src/features/home/domain/models/movie_session_mapper.dart';
import 'package:qwid/src/features/home/domain/models/type_mapper.dart';

import 'movie.dart';

extension MovideData on MovieDto {
  MovieModel toModel() => MovieModel(
      genres: genres?.asMap().entries.map((e) => e.value.toModel()).toList(),
      types: types?.asMap().entries.map((e) => e.value.toModel()).toList(),
      v: v,
      subtitle: subtitle,
      language: language,
      avatarUrl: avatarUrl,
      trailerUrl: trailerUrl,
      description: description,
      duration: duration,
      casts: casts,
      director: director,
      endDate: endDate,
      startDate: startDate,
      name: name,
      slug: slug,
      id: id,
      sessions:
          sessions?.asMap().entries.map((e) => e.value.toModel()).toList());
}
