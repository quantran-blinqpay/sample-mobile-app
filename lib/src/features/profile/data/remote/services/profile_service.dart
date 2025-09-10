import 'dart:convert';

import 'package:qwid/src/features/profile/domain/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:qwid/src/core/network/response/object_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/profile_dto.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/profile_dto.dart'
    as dto;

part 'profile_service.g.dart';

@RestApi()
abstract class ProfileService {
  factory ProfileService(Dio dio) = _ProfileService;

  @GET('/api/user/me/basic')
  Future<UserDataResponse> getMyProfile(@CancelRequest() CancelToken cancelToken);

  @PUT('/api/client/profile')
  Future<ObjectResponse<dynamic>> changePassword(@Body() Map<String, dynamic> body,
      @CancelRequest() CancelToken cancelToken);

  @GET('/api/user/{username}')
  Future<UserDataResponse> getUserProfile(
      @Path("username") String username,
      @Query("include") String include,
      @CancelRequest() CancelToken cancelToken);

  @GET('/api/user/me')
  Future<UserDataResponse> getMe(@Query("include") String include);
}
