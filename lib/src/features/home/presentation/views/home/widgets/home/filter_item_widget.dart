import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class FilterItemWidget extends StatelessWidget {
  const FilterItemWidget(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
      decoration: BoxDecoration(
        color: appColors.coralBlue, // light purple background
        borderRadius: BorderRadius.circular(22), // fully rounded
      ),
      child: Center(
        child: Text(
          text,
          style: AppStyles.of(context).copyWith(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

}