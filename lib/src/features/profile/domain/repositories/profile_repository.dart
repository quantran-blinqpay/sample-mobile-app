import 'dart:convert';

import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/core/shared_prefs/profile_storage.dart';
import 'package:designerwardrobe/src/core/shared_prefs/username_storage.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/auth_service.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/profile/domain/model/get_drafts_response.dart';
import 'package:dio/dio.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:designerwardrobe/src/features/profile/domain/model/user_data.dart';
import '../../data/remote/services/profile_service.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserData>> getBasicProfile();

  Future<Either<Failure, UserData>> getUserProfile({required String username});

  Future<Either<Failure, UserData?>> getMyProfile();

  Future<Either<Failure, bool>> changePassword(
      {required String password, required String newPassword});

  Future<Either<Failure, GetDraftsResponse?>> getDrafts(
    int page,
    String include,
  );

  Future<Either<Failure, ListingDetailResponse?>> getListingDetail(int id);

  Future<Either<Failure, UserData>> getMe();

  /// cancel token
  void cancelRequest();
}

class ProfileRepositoryImpl implements ProfileRepository {
  CancelToken? _getMyProfileCancelToken;
  CancelToken? _getUserProfileCancelToken;
  CancelToken? _changePassCancelToken;

  @override
  ProfileRepositoryImpl();

  @override
  Future<Either<Failure, UserData>> getBasicProfile() async {
    _getMyProfileCancelToken = CancelToken();
    try {
      final service = ProfileService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.getMyProfile(_getMyProfileCancelToken!);
      if (result.data != null) {
        return Right(result.data!);
      } else {
        return Left(DetailFailure(message: 'Getting Your Profile has failed'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserProfile(
      {required String username}) async {
    _getUserProfileCancelToken = CancelToken();
    try {
      final service = ProfileService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.2+json',
      ));
      var result = await service.getUserProfile(
        username,
        'Counts,StoreInformation,Detail',
        _getUserProfileCancelToken!,
      );
      if (result.data != null) {
        return Right(result.data!);
      } else {
        return Left(DetailFailure(message: 'Getting User Profile has failed'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserData?>> getMyProfile() async {
    _getUserProfileCancelToken = CancelToken();
    try {
      String? input;
      var json = await di<ProfileStorage>().read();
      if (json?.isNotEmpty ?? false) {
        final user = jsonDecode(json ?? '');
        return Right(UserData.fromJson(user));
      } else {
        input = await di<UsernameStorage>().read();
      }

      final service = ProfileService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.2+json',
      ));
      var result = await service.getUserProfile(
        input ?? '',
        'Counts,StoreInformation,Detail',
        _getUserProfileCancelToken!,
      );
      if (result.data != null) {
        final json = jsonEncode(result.data);
        await di<ProfileStorage>().write(json);
        return Right(result.data!);
      } else {
        return Left(DetailFailure(message: 'Getting User Profile has failed'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserData>> getMe() async {
    _getUserProfileCancelToken = CancelToken();
    try {
      final service = ProfileService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.getMe(
        'Cart',
      );
      if (result.data != null) {
        return Right(result.data!);
      } else {
        return Left(DetailFailure(message: 'Getting User Profile has failed'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String password, required String newPassword}) async {
    _changePassCancelToken = CancelToken();
    try {
      final service = ProfileService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.changePassword({
        "password": password,
        "new_password": newPassword,
      }, _changePassCancelToken!);
      if (result.code == 0) {
        return const Right(true);
      } else {
        return Left(DetailFailure(message: result.message));
      }
    } catch (e) {
      if (e is DioError) {
        String code = e.response?.data['errors'][0]['messages'][0];
        switch (code) {
          case 'PASSWORD_MIN':
            return Left(
                DetailFailure(message: 'Mật khẩu cần tối thiểu 6 ký tự'));
          case 'INVALID_PASSWORD':
            return Left(DetailFailure(message: 'Mật khẩu cũ không chính xác'));
        }
      }
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetDraftsResponse?>> getDrafts(
    int page,
    String include,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.getDrafts(page, include);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ListingDetailResponse?>> getListingDetail(
    int id,
  ) async {
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.3+json',
      ));
      var result = await service.getListingDetail(
        id,
        'PrimaryImage,SecondaryImages,Questions,Offers,User,User.Counts,Buyer,AcceptedOffer,OrderListings,OrderListings.Order,OrderListings.Order.CourierBags,Detail,Counts,Stock,Sizes,PurchasingOrder.CourierBags,PurchasingOrder,PurchasingOrder.PaymentDetails,DeliveryAddress,Feedback,ListingStyle',
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  void cancelRequest() {
    _getMyProfileCancelToken?.cancel();
  }
}
