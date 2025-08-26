import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:designerwardrobe/src/configs/app_configs/app_config.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/exceptions/app_exceptions.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/core/shared_prefs/access_token_storage.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor({required Future<String?> Function() getBearerToken})
      : _bearerToken = getBearerToken,
        super();

  final Future<String?> Function() _bearerToken;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await _bearerToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
        super.onRequest(options, handler);
      } else {
        final e =
             NotAuthenticatedException(message: 'NotAuthenticatedException');
        handler.reject(DioError(
            requestOptions: options, type: DioErrorType.cancel, error: e));
      }
    } on NotAuthenticatedException catch (e) {
      handler.reject(DioError(
          requestOptions: options, type: DioErrorType.cancel, error: e));
    } catch (e) {
      rethrow;
    }
  }
}
