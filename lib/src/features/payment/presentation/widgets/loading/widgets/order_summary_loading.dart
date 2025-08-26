import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/loading/widgets/list_order_loading.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/loading/widgets/promo_code_input_loading.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/loading/widgets/total_to_pay_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OrderSummaryLoading extends StatelessWidget {
  const OrderSummaryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          _buildHeader(context),
          SizedBox(height: 15),
          ListOrderLoading(),
          SizedBox(height: 10),
          _sellerName(context),
          SizedBox(height: 15),
          _buildOrderInput(context),
          SizedBox(height: 15),
          _buildRedeemGiftCard(context),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(color: appColors.silverSand, height: 0.5),
          ),
          _buildTotalToPay(context)
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Text(
      'Order summary',
      style: AppStyles.of(context).copyWith(
        color: appColors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _sellerName(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Text(
          'Seller: ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: appColors.dimGray,
          ),
        ),
        AppShimmer(width: 100, height: 20,)
      ],
    );
  }

  Widget _buildOrderInput(BuildContext context) {
    return PromoCodeInputLoading();
  }

  Widget _buildRedeemGiftCard(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Have a gift card? ',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: appColors.outerSpace,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // parentContext.router.maybePop();
              },
            text: 'Redeem here.',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: appColors.outerSpace,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalToPay(BuildContext context) {
    return TotalToPayLoading();
  }
}