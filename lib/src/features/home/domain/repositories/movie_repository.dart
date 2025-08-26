import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:designerwardrobe/src/features/home/domain/models/movie.dart';
import 'movie_repository_mapper.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getTopPage(String date);
}

class MovieRepositoryImpl extends MovieRepository {
  MovieRepositoryImpl();

  @override
  Future<Either<Failure, List<MovieModel>>> getTopPage(String date) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.1+json',
      ));
      final result = await service.getTopPage(date);
      if (result.code == 0) {
        return Right(MovieMapper.mapToModel(result));
      } else {
        return Left(DetailFailure(message: result.message));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
