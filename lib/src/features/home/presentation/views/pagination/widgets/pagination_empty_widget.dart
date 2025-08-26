import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:flutter/material.dart';

class PaginationEmptyWidget extends StatelessWidget {
  const PaginationEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: appColors.silverSand,
            ),
            const SizedBox(height: 24),
            Text(
              'No Products Found',
              style: TextStyle(
                fontFamily: 'FeatureDeckCondensed',
                fontSize: 24,
                color: appColors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'We couldn\'t find any recommended products at the moment.\nPlease try again later.',
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                color: appColors.silverSand,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
