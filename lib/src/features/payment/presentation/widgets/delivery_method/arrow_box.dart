import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:flutter/material.dart';

class ArrowBox extends StatelessWidget {
  const ArrowBox({super.key, required this.isDown, this.color});

  final bool isDown;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? appColors.chrome,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(
            isDown ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            size: 20),
      ),
    );
  }
}
