import 'package:dartz/dartz.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/auth_service.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/parameters/counter_offer_parameter.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/parameters/make_offer_parameter.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/response/make_offer_response.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/recommended_item.dart';
import 'package:designerwardrobe/src/features/helper/dtos/site_setting_data.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/watchlist/watchlist_item.dart';
import 'package:dio/dio.dart';

abstract class HomeRepository {
  Future<Either<Failure, String>> loadRecombeeSession();

  Future<Either<Failure, RecommendedItems?>> loadRecommendedItems(
      String recombeeSessionId);

  Future<Either<Failure, RecommendedItems?>> loadNextItems(String recommId);

  Future<Either<Failure, SiteSettingData?>> loadAllSiteSettings();

  Future<Either<Failure, WatchlistItem?>> loadWatchList();

  Future<Either<Failure, MakeOfferResponse?>> makeOffer(
      MakeOfferParameter parameter);

  Future<Either<Failure, bool?>> counterOffer(CounterOfferParameter parameter);

  /// cancel token
  void cancelRequest();
}

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl();

  CancelToken? _loadWatchListCancelToken;

  @override
  Future<Either<Failure, String>> loadRecombeeSession() async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.loadRecombeeSession();
      if (result.success == true) {
        return Right(result.sessionId ?? '');
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch recombee session'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecommendedItems?>> loadRecommendedItems(
      String recombeeSessionId) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
        recombeeSessionId: recombeeSessionId,
      ));
      final result =
          await service.loadRecommendedItems('you_may_like_homepage', 'NZ');
      if (result.recommId?.isNotEmpty ?? false) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch recommended items'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecommendedItems?>> loadNextItems(
      String recommId) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.loadNextItems(recommId);
      if (result.recommId?.isNotEmpty ?? false) {
        return Right(result);
      } else {
        return Left(
            DetailFailure(message: 'Can\'t fetch next recommended items'));
      }
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
  Future<Either<Failure, WatchlistItem?>> loadWatchList() async {
    _loadWatchListCancelToken = CancelToken();
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.loadWatchList(_loadWatchListCancelToken!);
      if (result.data?.isNotEmpty == true) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch site settings'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  void cancelRequest() {
    _loadWatchListCancelToken?.cancel();
  }

  @override
  Future<Either<Failure, MakeOfferResponse?>> makeOffer(
      MakeOfferParameter parameter) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.makeOffer(parameter.toJson());
      if (result.data != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t make an offer'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> counterOffer(
      CounterOfferParameter parameter) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.counterOffer(parameter.toJson());
      if (result.response.statusCode == 200) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t counter an offer'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
