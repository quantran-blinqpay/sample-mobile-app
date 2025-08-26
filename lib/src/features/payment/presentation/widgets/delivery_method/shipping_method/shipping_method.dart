import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/arrow_box.dart';
import 'package:flutter/material.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Shipping method', style: AppStyles.of(context).copyWith(
                color: appColors.outerSpace,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
            ),
            ArrowBox(isDown: true),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                'Tracked shipping (NZ Post) 5-7 days',
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: appColors.black,
                ),
              ),
            ),
            Text(
              'FREE',
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: appColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

}