import 'package:flutter/material.dart';

class AppWillPopScope extends StatelessWidget {
  const AppWillPopScope(
      {required this.child,
      super.key,
      this.onPop,
      this.shouldOveridePopScope = false});

  final Widget child;
  final VoidCallback? onPop;
  final bool shouldOveridePopScope;

  @override
  Widget build(BuildContext context) {
    return shouldOveridePopScope
        ? WillPopScope(
            child: child,
            onWillPop: () async {
              onPop?.call();
              return false;
            })
        : child;
  }
}
