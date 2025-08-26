import 'package:flutter/material.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';

class LanguageItem extends StatelessWidget {
  LanguageItem({
    super.key,
    this.text = '',
    this.enableSeparate = true,
    this.onTap,
    this.isSelected = false});

  String text;
  bool enableSeparate;
  Function? onTap;
  bool isSelected;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : null,
      child: Container(
        color: appColors!.settingItemBackground,
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
                    style: TextStyle(
                        color: appColors!.settingTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(width: 12),
                Visibility(
                    visible: isSelected,
                    child: Icon(Icons.check_circle_outline_outlined, color: appColors!.red, size: 20,)),
                Visibility(
                    visible: !isSelected,
                    child: const SizedBox(width: 20, height: 20)),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: enableSeparate,
              child: Container(color: appColors!.settingSeparateColor, height: 1),
            ),
          ],
        ),
      ),
    );
  }
}
