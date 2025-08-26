
import '../../data/remote/dtos/genre_dto.dart';
import 'genre.dart';

extension GenreData on GenreDto {
  GenreModel toModel() => GenreModel(
      id: id,
      updatedAt: updatedAt,
      createdAt: createdAt,
      code: code,
      name: name);
}