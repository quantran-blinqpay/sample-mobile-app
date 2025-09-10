import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:qwid/src/core/network/client/client_provider.dart';
import 'package:qwid/src/features/authentication/data/remote/services/auth_service.dart';
import 'package:qwid/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_search_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/my_size_response.dart';
import 'package:dartz/dartz.dart';

abstract class FilterRepository {
  Future<Either<Failure, FilterSearchResponse>> search(
    int page, {
    String? textSearch,
    String? sort,
    String? categories,
    List<String>? brands,
    String? sizes,
    List<String>? colour,
    String? priceRanges,
    String? minDiscount,
    List<String>? condition,
    String? location,
  });

  Future<Either<Failure, MySizeResponse?>> getMySize();
}

class FilterRepositoryImpl extends FilterRepository {
  FilterRepositoryImpl();

  @override
  Future<Either<Failure, FilterSearchResponse>> search(
    int page, {
    String? textSearch,
    String? sort,
    String? categories,
    List<String>? brands,
    String? sizes,
    List<String>? colour,
    String? priceRanges,
    String? minDiscount,
    List<String>? condition,
    String? location,
  }) async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.search(
        page: page,
        perPage: 10,
        textSearch: textSearch,
        sort: sort,
        categories: categories,
        brands: brands,
        sizes: sizes,
        colours: colour,
        priceRanges: priceRanges,
        minDiscount: minDiscount,
        condition: condition,
        location: location,
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MySizeResponse?>> getMySize() async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.getMySizes();
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
