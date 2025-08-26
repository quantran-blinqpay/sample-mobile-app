import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/arrow_box.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/payment_method/payment_method.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/shipping_method/shipping_method.dart';
import 'package:flutter/material.dart';

class DeliveryMethodLoading extends StatelessWidget {
  const DeliveryMethodLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(color: appColors.silverSand, height: 0.5),
          ),
          _buildShippingTo(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(color: appColors.silverSand, height: 0.5),
          ),
          _buildShippingMethod(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(color: appColors.silverSand, height: 0.5),
          ),
          _buildPaymentMethod(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Deliver Method', style: AppStyles.of(context).copyWith(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        )),
        const SizedBox(height: 10),
        Text('Tracked shipping arranged by seller',
            style: AppStyles.of(context).copyWith(
              color: appColors.outerSpace,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }

  Widget _buildShippingTo(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Ship to',
                  style: AppStyles.of(context).copyWith(
                    color: appColors.outerSpace,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            ArrowBox(isDown: true),
          ],
        ),
        const SizedBox(height: 10),
        AppShimmer(height: 18, width: 150,),
      ],
    );
  }

  Widget _buildShippingMethod(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Shipping method',
                  style: AppStyles.of(context).copyWith(
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
            AppShimmer(height: 18, width: 150),
            Spacer(),
            AppShimmer(height: 18, width: 50),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Payment method',
                  style: AppStyles.of(context).copyWith(
                    color: appColors.outerSpace,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            ArrowBox(isDown: true),
          ],
        ),
        const SizedBox(height: 10),
        AppShimmer(height: 18, width: 150),
      ],
    );
  }

}