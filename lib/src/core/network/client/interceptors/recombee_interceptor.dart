import 'package:dio/dio.dart';

class RecombeeInterceptor extends Interceptor {
  RecombeeInterceptor({required this.recombeeSessionId}) : super();

  final String recombeeSessionId;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers['recombee-session-id'] = recombeeSessionId;
      super.onRequest(options, handler);
    } catch (e) {
      rethrow;
    }
  }
}