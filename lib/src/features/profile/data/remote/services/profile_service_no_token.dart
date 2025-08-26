import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:designerwardrobe/src/core/network/response/object_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/profile_dto.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register_dto.dart';

part 'profile_service_no_token.g.dart';

@RestApi()
abstract class ProfileServiceNoToken {
  factory ProfileServiceNoToken(Dio dio) = _ProfileServiceNoToken;
}
