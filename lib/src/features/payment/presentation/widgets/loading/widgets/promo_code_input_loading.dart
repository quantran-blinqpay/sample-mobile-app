import 'package:qwid/src/components/loading_indicator/app_shimmer.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class PromoCodeInputLoading extends StatelessWidget {
  const PromoCodeInputLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promo code?',
          style: AppStyles.of(context).copyWith(
            color: appColors.outerSpace,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: appColors.silverSand, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextFormField(
                      controller: TextEditingController(),
                      backgroundColor: Colors.transparent,
                      keyboardType: TextInputType.name,
                      hintText: 'Enter it here',
                      readOnly: true,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: AppShimmer(height: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
