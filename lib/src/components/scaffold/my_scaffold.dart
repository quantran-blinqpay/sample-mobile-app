import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.center,
  });

  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? center;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [child, _appBar(context)],
        ),
      );

  Widget _appBar(BuildContext context) => SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading ?? const SizedBox.shrink(),
            center ?? const SizedBox.shrink(),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ));
}
