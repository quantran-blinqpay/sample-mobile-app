import 'package:flutter/material.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';

class OptionalItem extends StatelessWidget {
  OptionalItem(
      {super.key,
      this.text = '',
      this.enableSeparate = true,
      this.leadingIcon = const Icon(Icons.abc),
      this.onTap});
  String text;
  bool enableSeparate;
  Icon leadingIcon;
  Function? onTap;
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
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 20),
              leadingIcon,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: appColors!.profileTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.chevron_right),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: enableSeparate,
            child: Container(color: appColors!.profileSeparateColor, height: 1),
          ),
        ],
      ),
    );
  }
}
