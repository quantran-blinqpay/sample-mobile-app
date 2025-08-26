import 'package:designerwardrobe/src/core/network/response/array_response.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/movie_dto.dart';
import 'package:designerwardrobe/src/features/home/domain/models/movie.dart';
import 'package:designerwardrobe/src/features/home/domain/models/movie_mapper.dart';

class MovieMapper {
  static List<MovieModel> mapToModel(ArrayResponse<MovieDto> response) {
    return response.data.map((e) => e.toModel()).toList();
  }
}
