import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:qwid/src/core/network/client/client_provider.dart';
import 'package:qwid/src/core/network/response/default_response.dart';
import 'package:qwid/src/features/authentication/data/remote/services/auth_service.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/build_desc_by_ai_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/create_listing_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_commission_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_dwpost_freight_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_free_bump_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_price_recommend_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/search_brands_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/upload_image_response.dart';
import 'package:qwid/src/features/create_listing/domain/models/create_listing_model.dart';
import 'package:qwid/src/features/create_listing/domain/models/save_draft_model.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/get_condition_response.dart';

abstract class CreateListingRepository {
  Future<Either<Failure, UploadImageResponse>> uploadImage(File file);
  
  Future<Either<Failure, UploadImageResponse>> rotateImage(String? uploadId);

  Future<Either<Failure, DefaultResponse>> deleteImage(String? uploadId);

  Future<Either<Failure, BuildDescByAiResponse>> buildDescByAi(
    List<String>? photos,
  );

  Future<Either<Failure, GetPriceRecommendResponse>> getPriceRecommend(
    int? brandId,
    int? conditionId,
    int? categoryId,
  );

  Future<Either<Failure, List<SearchBrandsResponse>?>> searchBrands(
    String? textSearch,
    int categoryId,
  );

  Future<Either<Failure, GetConditionResponse?>> getConditions(int? id);

  Future<Either<Failure, GetDwpostFreightResponse?>> getDwpostFreight(
    int? id, {
    bool includeAu = true,
  });

  Future<Either<Failure, GetFreeBumpResponse?>> getFreeBump();

  Future<Either<Failure, GetCommissionResponse?>> getCommission(
    String? sellPrice,
    String? shippingPrice, {
    bool? isRental = false,
  });

  Future<Either<Failure, CreateListingResponse?>> createListing(
    CreateListingModel body,
  );

  Future<Either<Failure, CreateListingResponse?>> editListing(
    CreateListingModel body,
  );

  Future<Either<Failure, bool?>> saveDraft(
    SaveDraftModel body,
  );
}

class CreateListingRepositoryImpl extends CreateListingRepository {
  CreateListingRepositoryImpl();

  @override
  Future<Either<Failure, UploadImageResponse>> uploadImage(File file) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.uploadImage(file);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UploadImageResponse>> rotateImage(String? uploadId) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final obj = {"s3_file_key": uploadId};

      final result = await service.rotateImage(obj);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DefaultResponse>> deleteImage(String? uploadId) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final obj = {"s3_file_key": uploadId};

      final result = await service.deleteImage(obj);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BuildDescByAiResponse>> buildDescByAi(
    List<String>? photos,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final obj = {"images": photos};

      final result = await service.buildDescByAI(obj);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetPriceRecommendResponse>> getPriceRecommend(
    int? brandId,
    int? conditionId,
    int? categoryId,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final obj = {
        "brand_id": brandId,
        "condition_id": conditionId,
        "category_id": categoryId,
      };

      final result = await service.getPriceRecommendation(obj);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchBrandsResponse>?>> searchBrands(
    String? textSearch,
    int categoryId,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.searchBrands(
        textSearch: textSearch,
        categoryId: categoryId,
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetConditionResponse?>> getConditions(int? id) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.getConditions(id: id);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetDwpostFreightResponse?>> getDwpostFreight(
    int? id, {
    bool includeAu = true,
  }) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.getDwpostFreight(id: id, includeAu: includeAu);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetFreeBumpResponse?>> getFreeBump() async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.getFreeBump();
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetCommissionResponse?>> getCommission(
    String? sellPrice,
    String? shippingPrice, {
    bool? isRental = false,
  }) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.getCommission(
        sellPrice: sellPrice,
        shippingPrice: shippingPrice,
        isRental: isRental,
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateListingResponse?>> createListing(
    CreateListingModel body,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.createListing(body: body);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateListingResponse?>> editListing(
    CreateListingModel body,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.editListing(body: body);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> saveDraft(
    SaveDraftModel body,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.saveDraft(body: body);
      bool isSuccess = false;

      if (result is List<dynamic>) {
        isSuccess = result.isNotEmpty && result.first == 'success';
      } else if (result is Map<String, dynamic>) {
        isSuccess =
            result['status'] == 'success' || result['message'] == 'success';
      }

      return Right(isSuccess);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
