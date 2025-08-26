import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/extensions/amount.dart';
import 'package:flutter/material.dart';

class TotalToPayLoading extends StatelessWidget {
  const TotalToPayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      children: [
        SizedBox(height: 10),
        _buildRow(
            context: context,
            title: 'Subtotal (2 items)',
            amount: 788.00.asNZDFormat()),
        SizedBox(height: 8),
        _buildRow(
            context: context,
            title: 'Bundle discount (10% off)',
            amount: (-78.80).asNZDFormat(),
            isDiscount: true),
        SizedBox(height: 8),
        _buildRow(context: context, title: 'Shipping', amount: 'Free'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0),
          child: Divider(color: appColors.silverSand, height: 1),
        ),
        _buildTotal(context),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _buildRow(
      {required BuildContext context,
      required String title,
      required String amount,
      bool isDiscount = false}) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        AppShimmer(height: 14, width: 150),
        Spacer(),
        AppShimmer(height: 14, width: 100),
      ],
    );
  }

  Widget _buildTotal(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Expanded(
          child: Text(
            'Total to pay',
            style: AppStyles.of(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: appColors.black,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppShimmer(height: 12, width: 50),
            SizedBox(width: 2),
            AppShimmer(height: 18, width: 80),
          ],
        ),
      ],
    );
  }
}
