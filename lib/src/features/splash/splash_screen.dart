import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage(name: splashScreenName)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().initData();
  }

  Future<void> _fetchingHelper() async {
    await context.read<HelperCubit>().initData();
  }

  void _onNavigated() {
    if (!mounted || _navigated) return;
    _navigated = true;
    context.router.replace(OnboardingScreenRoute());
  }

  Future<void> _startAfterLoaded() async {
    final apiFuture = _fetchingHelper();

    await Future.wait([apiFuture]);
    _onNavigated();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E9DC),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.getTokenStatus == ProgressStatus.success) {
                if(state.token?.isNotEmpty ?? false){
                  context.router.replace(HomeWrapperScreenRoute());
                } else {
                  context.router.replace(SignInScreenRoute());
                }
              }

            },
          ),
        ],
        child: Center(
          child: Image.asset(
            icQwidBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
