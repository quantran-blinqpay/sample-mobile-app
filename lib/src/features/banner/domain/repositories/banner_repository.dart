import 'package:dartz/dartz.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:qwid/src/core/network/client/client_provider.dart';
import 'package:qwid/src/features/banner/data/remote/services/banner_service.dart';
import 'package:qwid/src/features/banner/domain/models/banner.dart';
import 'package:qwid/src/features/banner/domain/repositories/banner_repository_mapper.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<BannerModel>>> getBanner();
}

class BannerRepositoryImpl extends BannerRepository {

  BannerRepositoryImpl();

  @override
  Future<Either<Failure, List<BannerModel>>> getBanner() async {
    try {
      final service = BannerService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.getBanner();
      if (result.code == 0) {
        return Right(BannerRepositoryMapper.mapToModel(result));
      } else {
        return Left(DetailFailure(message: result.message));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
