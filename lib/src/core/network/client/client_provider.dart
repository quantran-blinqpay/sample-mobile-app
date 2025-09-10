import 'package:qwid/src/core/network/client/interceptors/api_version_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:qwid/src/configs/app_configs/app_config.dart';
import 'package:qwid/src/core/network/client/interceptors/interceptors.dart';

class AppDio {
  AppConfig appConfig;

  AppDio(this.appConfig);

  factory AppDio.init(AppConfig config) {
    AppDio result = AppDio(config);
    return result;
  }

  /// No-token required + accept = application/vnd.dw.v1.1+json
  Dio getSimpleDio({required String baseUrl}) {
    Dio dio = Dio();
    dio.interceptors.addAll([
      InterceptorBuilder.logger,
    ]);
    dio.options.baseUrl = baseUrl;
    return dio;

  }

  /// No-token required + accept = application/vnd.dw.v1.1+json
  Dio getNoTokenDio({String? apiContentType, String? recombeeSessionId}) {
    Dio dio = Dio();
    /// apiContentType == null && recombeeSessionId == null
    if(apiContentType == null && recombeeSessionId == null) {
      dio.interceptors.addAll([
        InterceptorBuilder.userAgent,
        InterceptorBuilder.logger,
      ]);
      dio.options.baseUrl = appConfig.baseUrl;
      return dio;
    }

    /// apiContentType != null && recombeeSessionId == null
    if(apiContentType != null && recombeeSessionId == null) {
      dio.interceptors.addAll([
        InterceptorBuilder.acceptApiVersion(apiContentType),
        InterceptorBuilder.userAgent,
        InterceptorBuilder.logger,
      ]);
      dio.options.baseUrl = appConfig.baseUrl;
      return dio;
    }

    /// apiContentType == null && recombeeSessionId != null
    if(apiContentType == null && recombeeSessionId != null) {
      dio.interceptors.addAll([
        InterceptorBuilder.attachRecombee(recombeeSessionId),
        InterceptorBuilder.userAgent,
        InterceptorBuilder.logger,
      ]);
      dio.options.baseUrl = appConfig.baseUrl;
      return dio;
    }

    /// apiContentType != null && recombeeSessionId != null
    dio.interceptors.addAll([
      InterceptorBuilder.acceptApiVersion(apiContentType!),
      InterceptorBuilder.attachRecombee(recombeeSessionId!),
      InterceptorBuilder.userAgent,
      InterceptorBuilder.logger,
    ]);
    dio.options.baseUrl = appConfig.baseUrl;
    return dio;

  }

  /// No-token required + accept = application/vnd.dw.v1.1+json
  Dio getAuthDio({String? apiContentType, String? recombeeSessionId}) {
    Dio dio = Dio();
    /// apiContentType == null && recombeeSessionId == null
    if(apiContentType == null && recombeeSessionId == null) {
      dio.interceptors.addAll([
        InterceptorBuilder.authorization,
        InterceptorBuilder.userAgent,
        InterceptorBuilder.logger,
      ]);
      dio.options.baseUrl = appConfig.baseUrl;
      return dio;
    }

    /// apiContentType != null && recombeeSessionId == null
    if(apiContentType != null && recombeeSessionId == null) {
      dio.interceptors.addAll([
        InterceptorBuilder.authorization,
        InterceptorBuilder.acceptApiVersion(apiContentType),
        InterceptorBuilder.userAgent,
        InterceptorBuilder.logger,
      ]);
      dio.options.baseUrl = appConfig.baseUrl;
      return dio;
    }

    /// apiContentType == null && recombeeSessionId != null
    if(apiContentType == null && recombeeSessionId != null) {
      dio.interceptors.addAll([
        InterceptorBuilder.authorization,
        InterceptorBuilder.attachRecombee(recombeeSessionId),
        InterceptorBuilder.userAgent,
        InterceptorBuilder.logger,
      ]);
      dio.options.baseUrl = appConfig.baseUrl;
      return dio;
    }

    /// apiContentType != null && recombeeSessionId != null
    dio.interceptors.addAll([
      InterceptorBuilder.authorization,
      InterceptorBuilder.acceptApiVersion(apiContentType!),
      InterceptorBuilder.attachRecombee(recombeeSessionId!),
      InterceptorBuilder.userAgent,
      InterceptorBuilder.logger,
    ]);
    dio.options.baseUrl = appConfig.baseUrl;
    return dio;
  }

}
