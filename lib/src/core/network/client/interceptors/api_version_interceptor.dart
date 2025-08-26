import 'package:dio/dio.dart';

class ApiVersionInterceptor extends Interceptor {
  ApiVersionInterceptor({required this.apiContentType}) : super();

  final String apiContentType;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers['Accept'] = apiContentType;
      super.onRequest(options, handler);
    } catch (e) {
      rethrow;
    }
  }
}