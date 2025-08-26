import 'dart:ui' as ui;
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.shadowColor,
    this.backgroundColor,
  });

  final Color? shadowColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SizedBox.expand(
      child: ColoredBox(
        color: shadowColor ?? appColors.black.withAlpha(40),
        child: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 70),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor ?? appColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: CupertinoActivityIndicator(
                radius: 16, // default = 10, make it bigger if needed
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class RoseTintOverlay extends StatelessWidget {
  const RoseTintOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SizedBox.expand(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Builder(
          builder: (context) => ColoredBox(
            color: appColors.red.withAlpha(120),
          ),
        ),
      ),
    );
  }
}

class LoadingAccountOverlay extends StatelessWidget {
  const LoadingAccountOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: ColoredBox(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(child: SquareLoadingAccountWidget()),
      ),
    );
  }
}

class SquareLoadingAccountWidget extends StatelessWidget {
  const SquareLoadingAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
        width: 174,
        height: 174,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Lottie.asset('lib/assets/images/lottie/square-loader.json',
            fit: BoxFit.contain, alignment: Alignment.center));
  }
}
