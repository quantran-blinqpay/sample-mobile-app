import 'package:dio/dio.dart';

class UserAgentInterceptor extends Interceptor {
  UserAgentInterceptor() : super();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers['User-Agent'] = 'kWXVDsQ7zJ98EYEGoLZmWThdWSwyt6GG';
      super.onRequest(options, handler);
    } catch (e) {
      rethrow;
    }
  }
}