import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class NewBadgeWidget extends StatelessWidget {
  const NewBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: appColors.skyBlue,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child: Text(
            'NEW',
            style: AppStyles.of(context).copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: appColors.vividBlue),
          ),
        ),
      ),
    );
  }
}
