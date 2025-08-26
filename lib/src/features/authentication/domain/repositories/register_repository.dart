import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/brand_following_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/category_size_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/batch_update_frequency_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/brand_following_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/code_sending_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/code_verification_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/size_sync_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/user_validation_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/batch_update_frequency_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/code_sending_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/code_verification_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/email_validation_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/size_sync_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/user_validation_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/username_validation_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:dio/dio.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:designerwardrobe/src/features/authentication/domain/model/register.dart';
import 'package:designerwardrobe/src/features/authentication/domain/repositories/auth_repository_mapper.dart';
import 'dart:io' show HttpStatus;

import '../../data/remote/services/auth_service.dart';

abstract class RegisterRepository {
  Future<Either<Failure, EmailValidationResponse>> validateEmail({
    required String email,
  });

  Future<Either<Failure, UsernameValidationResponse>> validateUserName({
    required String username
  });

  Future<Either<Failure, UserValidationResponse>> validateUser({
    required UserValidationParameter param
  });

  Future<Either<Failure, CodeSendingResponse>> sendCode({
    required CodeSendingParameter param
  });

  Future<Either<Failure, BatchUpdateFrequencyResponse>> batchUpdateFrequency({
    required BatchUpdateFrequencyParameter param
  });

  Future<Either<Failure, SizeSyncResponse>> syncSize({
    required SizeSyncParameter param
  });

  Future<Either<Failure, CategorySizeResponse?>> loadStartupCategories();

  Future<Either<Failure, BrandFollowingResponse>> followBrand({
    required BrandFollowingParameter param});

  /// cancel token
  void cancelRequest();
}

class RegisterRepositoryImpl implements RegisterRepository {

  @override
  RegisterRepositoryImpl();

  @override
  Future<Either<Failure, EmailValidationResponse>> validateEmail({required String email}) async {
    try{
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.validateEmail(email);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UsernameValidationResponse>> validateUserName({
    required String username}) async {
    try{
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.validateUserName(username);
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserValidationResponse>> validateUser({
    required UserValidationParameter param
  }) async {
    try{
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.validateUser(param.toJson());
      if(result.success ?? false) {
        return Right(result);
      } else if(result.errors?.username?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.username?.first));
      } else if(result.errors?.referralCode?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.referralCode?.first));
      } else if(result.errors?.terms?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.terms?.first));
      } else if(result.errors?.password?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.password?.first));
      } else if(result.errors?.firstName?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.firstName?.first));
      } else if(result.errors?.lastName?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.lastName?.first));
      } else if(result.errors?.email?.isNotEmpty ?? false){
        return Left(DetailFailure(message: result.errors?.email?.first));
      } else {
        return Left(DetailFailure(message: 'Unknown problem!'));
      }

    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CodeSendingResponse>> sendCode({
    required CodeSendingParameter param
  }) async {
    try{
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.sendCode(param.toJson());
      if(result.status == 'success') {
        return Right(result);
      } else {
        return Left(DetailFailure(message: result.message));
      }

    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BatchUpdateFrequencyResponse>> batchUpdateFrequency({
    required BatchUpdateFrequencyParameter param}) async {
    try{
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.batchUpdateFrequency(param.toJson());
      if(result.success ?? false) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: "Your notification preferences have been failed!"));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SizeSyncResponse>> syncSize({
    required SizeSyncParameter param}) async {
    try{
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.syncSize(param.toJson());
      if(result.data != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: "Unknown problem!"));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategorySizeResponse?>> loadStartupCategories() async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.1+json',
      ));
      final result = await service.loadStartupCategories(
          'categories', 'nz', 'is_top_rental,is_top_sale,popularity_score');
      if (result.categories?.isNotEmpty ?? false) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch site settings'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BrandFollowingResponse>> followBrand({
    required BrandFollowingParameter param}) async {
    try{
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.followBrand(param.toJson());
      if(result.data != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: "Unknown problem!"));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  void cancelRequest() {
    // TODO: implement cancelRequest
  }

}
