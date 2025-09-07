import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
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
  // late final AnimationController _controller;
  // guard against double-calls
  bool _started = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Wait 1 second before navigating
    Future.wait([Future.delayed(const Duration(seconds: 3))]).then((value) {
      _startAfterLoaded().then((value) {
        _onNavigated();
      });
    });
  }

  Future<void> _fetchingHelper() async {
    await context.read<HelperCubit>().initData();
  }

  void _onNavigated() {
    if (!mounted || _navigated) return;
    _navigated = true;
    context.router.replace(OnboardingOneScreenRoute());
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
      body: Center(
        child: Image.asset(
          qwidBg,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        )/*Lottie.asset(
          'assets/animations/Splash_Screen.json',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          controller: _controller,
          onLoaded: (composition) {
            if (_started) return;
            _started = true;
            _startAfterLoaded(composition);
          },
        )*/,
      ),
    );
  }
}
