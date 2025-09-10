import 'package:qwid/src/core/network/client/client_provider.dart';
import 'package:qwid/src/core/network/client/interceptors/api_version_interceptor.dart';
import 'package:qwid/src/core/network/client/interceptors/custom_dio_logger.dart';
import 'package:qwid/src/core/network/client/interceptors/recombee_interceptor.dart';
import 'package:qwid/src/core/network/client/interceptors/user_agent_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/network/client/interceptors/authorization_interceptor.dart';
import 'package:qwid/src/core/shared_prefs/access_token_storage.dart';
import 'package:qwid/src/features/authentication/data/remote/services/auth_service.dart';

export 'authorization_interceptor.dart';

class InterceptorBuilder {
  InterceptorBuilder._();

  static AuthorizationInterceptor authorization =
      AuthorizationInterceptor(getBearerToken: () async {
    try {
      var token = await di<AccessTokenStorage>().read();
      return token;
    } catch (e) {
      rethrow;
    }
  });

  static UserAgentInterceptor userAgent = UserAgentInterceptor();

  static ApiVersionInterceptor acceptApiVersion(String apiContentType) =>
      ApiVersionInterceptor(apiContentType: apiContentType);

  static RecombeeInterceptor attachRecombee(String recombeeSessionId) =>
      RecombeeInterceptor(recombeeSessionId: recombeeSessionId);

  static Interceptor get logger {
    if (kDebugMode) {
      return CustomDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        excludePaths: [
          '/api/helper/startup',
          '/api/helper/site-settings/all',
        ],
      );
    } else {
      return const Interceptor();
    }
  }

  static Interceptor get refreshToken {
    final dio = di<AppDio>().getNoTokenDio(
      apiContentType: 'application/vnd.dw.v1+json',
    );
    return Fresh<String>(
        shouldRefresh: (Response? response) {
          return response?.statusCode == 401;
        },
        tokenStorage: di<AccessTokenStorage>(),
        refreshToken: (token, client) async {
          final service = AuthService(dio);
          var result = await service.refreshToken();
          return result.token;
        },
        httpClient: dio,
        tokenHeader: (String token) {
          return {
            'Authorization': 'Bearer $token',
          };
        });
  }
}
