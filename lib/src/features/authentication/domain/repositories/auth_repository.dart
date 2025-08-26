import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/code_verification_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/user_creation_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/code_verification_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/username_creation_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:dio/dio.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:designerwardrobe/src/features/authentication/domain/model/register.dart';
import 'package:designerwardrobe/src/features/authentication/domain/repositories/auth_repository_mapper.dart';
import 'dart:io' show HttpStatus;

import '../../data/remote/services/auth_service.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signIn({
    required String userName,
    required String password,
  });

  Future<Either<Failure, bool>> signOut();

  Future<Either<Failure, RegisterModel?>> register({
    required String userName,
    required String password,
    required String fullName,
    required String phone,
  });

  Future<Either<Failure, bool>> forgotPassword({
    required String userName,
  });

  Future<Either<Failure, CodeVerificationResponse>> verifyCode({
    required CodeVerificationParameter param
  });

  Future<Either<Failure, UsernameCreationResponse>> createUser({
    required UserCreationParameter param});

  /// cancel token
  void cancelRequest();
}

class AuthRepositoryImpl implements AuthRepository {
  CancelToken? _signInCancelToken;
  CancelToken? _registerCancelToken;
  CancelToken? _logoutCancelToken;
  CancelToken? _forgotPasswordCancelToken;

  @override
  AuthRepositoryImpl();

  @override
  Future<Either<Failure, String>> signIn(
      {required String userName, required String password}) async {
    final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
    ));
    _signInCancelToken = CancelToken();
    try {
      final result = await service.signIn(
          {"email": userName, "password": password}, _signInCancelToken!);
      if (result.statusCode == 200) {
        return Right(SignInMapper.mapToModel(result));
      } else {
        return Left(DetailFailure(message: 'Login fail'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    _logoutCancelToken = CancelToken();
    try {
      final service = AuthService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      var result = await service.signOut(_logoutCancelToken!);
      if (result.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(DetailFailure(message: result.message));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel?>> register({
    required String userName,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    _registerCancelToken = CancelToken();
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
          apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.register({
        "username": userName,
        "password": password,
        "fullname": fullName,
        "phone": phone
      }, _registerCancelToken!);
      if (result.code == 0) {
        return Right(RegisterMapper.mapToModel(result));
      } else {
        return Left(DetailFailure(message: result.message));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword({
    required String userName,
  }) async {
    _forgotPasswordCancelToken = CancelToken();
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
          apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service
          .forgotPassword({"username": userName}, _forgotPasswordCancelToken!);
      if (result.code == 0) {
        return const Right(true);
      } else {
        return Left(DetailFailure(message: result.message));
      }
    } catch (e) {
      if (e is DioError) {
        return Left(DetailFailure(message: e.response?.statusMessage ?? ''));
      }
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CodeVerificationResponse>> verifyCode({
    required CodeVerificationParameter param}) async {
    try{
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.verifyCode(param.toJson());
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
  Future<Either<Failure, UsernameCreationResponse>> createUser({
    required UserCreationParameter param}) async {
    try{
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.createUser(param.toJson());
      if(result.statusCode == 200) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: "Your creating user have been failed!"));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }


  @override
  void cancelRequest() {
    _signInCancelToken?.cancel();
    _registerCancelToken?.cancel();
    _logoutCancelToken?.cancel();
    _forgotPasswordCancelToken?.cancel();
  }
}
