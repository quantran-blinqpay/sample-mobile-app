import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color,
    this.height,
    this.thickness,
  });

  final Color? color;
  final double? height;
  final double? thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Theme.of(context).extension<AppColors>()!.silverSand,
      height: height ?? 0.5,
      thickness: thickness ?? 0,
    );
  }
}
