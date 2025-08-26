import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/payment_method/payment_method.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/ship_to/ship_to.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/shipping_method/shipping_method.dart';
import 'package:flutter/material.dart';

class DeliveryMethod extends StatelessWidget {
  const DeliveryMethod({super.key});

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
    return ShipToWidget();
  }

  Widget _buildShippingMethod(BuildContext context) {
    return ShippingMethod();
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return PaymentMethod();
  }

}