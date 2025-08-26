import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/shared_prefs/access_token_storage.dart';
import 'package:designerwardrobe/src/router/router.dart';

class AuthGuard extends AutoRouteGuard {

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    try {
      var token = await di<AccessTokenStorage>().read();
      if (token?.isEmpty ?? true) {
        // If session is null it means user is logged out
        // redirect to login page
        router.replaceAll([HomeWrapperScreenRoute(), SignInScreenRoute()]);
      } else {
        // else continue navigation
        return resolver.next();
      }
    } catch (e) {
      router.replaceAll([HomeWrapperScreenRoute(), SignInScreenRoute()]);
    }
  }
}
