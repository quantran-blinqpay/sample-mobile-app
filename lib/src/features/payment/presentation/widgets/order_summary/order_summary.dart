import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/gift_card_input.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/list_order/list_order.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/promo_code_input.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/total_to_pay.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
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
          ListOrder(),
          SizedBox(height: 10),
          _sellerName(context),
          SizedBox(height: 15),
          _buildOrderInput(context),
          SizedBox(height: 15),
          _buildRedeemGiftCard(context),
          _buildGiftCardInput(context),
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
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Text(
          'Seller: ${state.productInfo == null ? '': '@${state.productInfo?.user?.data?.username}'}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: appColors.dimGray,
          ),
        );
      },
    );
  }

  Widget _buildOrderInput(BuildContext context) {
    return PromoCodeInput();
  }

  Widget _buildGiftCardInput(BuildContext context) {
    return _showGiftCard ? GiftCardInput(): SizedBox.shrink();
  }

  bool _showGiftCard = false;

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
                setState(() {
                  _showGiftCard = !_showGiftCard;
                });
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
    return TotalToPay();
  }
}