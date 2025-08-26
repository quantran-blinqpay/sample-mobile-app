import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.onTap,
      required this.icon,
      this.width,
      this.height});

  final VoidCallback onTap;
  final Icon icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
        alignment: Alignment.center,
        width: width ?? 48,
        height: height ?? 48,
        child: IconButton(onPressed: onTap, icon: icon));
  }
}
