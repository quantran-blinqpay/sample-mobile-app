import 'package:designerwardrobe/src/components/loading_indicator/app_modal_loader.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) => LoadingOverlay(
        color: Colors.transparent,
        progressIndicator: const AppLoadingIndicator(),
        isLoading: isLoading,
        child: child,
      );
}
