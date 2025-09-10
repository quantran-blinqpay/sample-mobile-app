import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:qwid/src/core/network/client/client_provider.dart';
import 'package:qwid/src/core/network/response/default_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/category/brand_following_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/parameter/brand_following_parameter.dart';
import 'package:qwid/src/features/authentication/data/remote/services/auth_service.dart';
import 'package:qwid/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:dartz/dartz.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_search_response.dart'
    show FilterSearchResponse;
import 'package:qwid/src/features/home/data/remote/dtos/recommended_item.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/all_question_response.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/ask_question_response.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';

abstract class ItemDetailRepository {
  Future<Either<Failure, ListingDetailResponse?>> getListingDetail(int id);
  Future<Either<Failure, AllQuestionResponse?>> getAllQuestion(int id);
  Future<Either<Failure, FilterSearchResponse>> getMoreFromSeller(
    String? user,
    int categoriesId,
  );
  Future<Either<Failure, RecommendedItems?>> getSimilarItem(
    String recombeeSessionId,
    int itemId,
  );

  Future<Either<Failure, BrandFollowingResponse>> followBrand({
    required BrandFollowingParameter param,
  });

  Future<Either<Failure, DefaultResponse>> addToFav(int id);

  Future<Either<Failure, DefaultResponse>> removeFromFav(int id);

  Future<Either<Failure, AskQuestionResponse>> askQuestion(
    int id,
    Map<String, dynamic> body,
  );
}

class ItemDetailRepositoryImpl extends ItemDetailRepository {
  ItemDetailRepositoryImpl();

  @override
  Future<Either<Failure, ListingDetailResponse?>> getListingDetail(
    int id,
  ) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.3+json',
      ));
      var result = await service.getListingDetail(
        id,
        'Tags,StandardSize,UserAddress,ShippingOption,PrimaryImage,SecondaryImages,User,User.Counts,User.StoreInformation,Stock,Detail,Counts,Sizes,SizeOnLabel,Buyer,Offers,Offers.CounterOffers,PurchasingOrder.PaymentDetails,PurchasingOrder,ListingStyle',
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AllQuestionResponse?>> getAllQuestion(
    int id,
  ) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.1+json',
      ));
      var result = await service.getAllQuestion(id);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FilterSearchResponse>> getMoreFromSeller(
    String? user,
    int categoriesId,
  ) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.search(
        user: user,
        categoriesId: categoriesId,
        perPage: 16,
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecommendedItems?>> getSimilarItem(
    String recombeeSessionId,
    int itemId,
  ) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
        recombeeSessionId: recombeeSessionId,
      ));

      final result = await service.loadRecommendedItems(
        'similar_items',
        'NZ',
        itemId: itemId,
      );

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
  Future<Either<Failure, BrandFollowingResponse>> followBrand(
      {required BrandFollowingParameter param}) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.followBrand(param.toJson());
      if (result.data != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: "Unknown problem!"));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DefaultResponse>> addToFav(
    int id,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.addToFav(id);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DefaultResponse>> removeFromFav(
    int id,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.removeFromFav(id);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AskQuestionResponse>> askQuestion(
    int id,
    Map<String, dynamic> body,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.1+json',
      ));
      final result = await service.askQuestion(id, body);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
