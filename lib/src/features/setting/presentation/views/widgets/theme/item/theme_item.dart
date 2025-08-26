import 'package:flutter/material.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';

class ThemeItem extends StatelessWidget {
  ThemeItem({
    super.key,
    this.text = '',
    this.enableSeparate = true,
    this.onTap,
    this.isSelected = false});

  String text;
  bool enableSeparate;
  Function? onTap;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : null,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(width: 12),
                Visibility(
                    visible: isSelected,
                    child: const Icon(Icons.check_circle_outline_outlined, color: AppColorss.crimson, size: 20,)),
                Visibility(
                    visible: !isSelected,
                    child: const SizedBox(width: 20, height: 20)),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: enableSeparate,
              child: Container(color: AppColorss.borderColor, height: 1),
            ),
          ],
        ),
      ),
    );
  }
}
