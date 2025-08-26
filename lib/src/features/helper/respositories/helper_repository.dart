import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:designerwardrobe/src/features/helper/dtos/currency_rate_response.dart';
import 'package:dartz/dartz.dart';
import 'package:designerwardrobe/src/features/helper/dtos/get_startup_response.dart';
import 'package:designerwardrobe/src/features/helper/dtos/site_setting_data.dart';

abstract class HelperRepository {
  Future<Either<Failure, GetStartupResponse>> loadStartup();

  Future<Either<Failure, SiteSettingData?>> loadAllSiteSettings();

  Future<Either<Failure, CurrencyRateResponse?>> getCurrencyRate();
}

class HelperRepositoryImpl extends HelperRepository {
  HelperRepositoryImpl();

  @override
  Future<Either<Failure, GetStartupResponse>> loadStartup() async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.1+json',
      ));
      final result = await service.loadStartup();
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SiteSettingData?>> loadAllSiteSettings() async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.loadAllSiteSettings();
      if (result.success == true) {
        return Right(result.data);
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch site settings'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurrencyRateResponse?>> getCurrencyRate() async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.getCurrencyRate();
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
