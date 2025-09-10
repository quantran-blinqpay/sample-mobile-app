import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:qwid/src/core/network/response/array_response.dart';
import 'package:qwid/src/features/banner/data/remote/dtos/banner_dto.dart';

part 'banner_service.g.dart';

@RestApi()
abstract class BannerService {
  factory BannerService(Dio dio) = _BannerService;

  @GET('/api/banner')
  Future<ArrayResponse<BannerDto>> getBanner();
}
