import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/extensions/amount.dart';
import 'package:qwid/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalToPay extends StatelessWidget {
  const TotalToPay({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final price = state.productInfo?.pricePattern?.calSalePrice(
            'NZ', state.dataCurrencyRate?.rateAudToNzd ?? 1);
        final originalPrice = state.productInfo?.pricePattern?.calOriginalPrice(
            'NZ', state.dataCurrencyRate?.rateAudToNzd ?? 1);
        final discount = state.productInfo?.pricePattern?.calDiscountPercent(
            salePrice: price ?? 0, originalPrice: originalPrice ?? 0);
        return Column(
          children: [
            SizedBox(height: 10),
            _buildRow(
                context: context,
                title: 'Subtotal (1 items)',
                amount: (state.paymentInfo?.pricing?.listingPrice ?? 0.0).asNZDFormat() ?? ''),
            // BlocBuilder<PaymentCubit, PaymentState>(
            //   builder: (context, state) {
            //     if(discount == 0.0) return SizedBox.shrink();
            //     return Padding(
            //       padding: const EdgeInsets.only(top: 8.0),
            //       child: _buildRow(
            //           context: context,
            //           title: 'Bundle discount ($discount% off)',
            //           amount: ((price ?? 0.0) -(originalPrice ?? 0.0)).toDouble().asNZDFormat(fallback: '-NZD \$0.00') ?? '',
            //           isDiscount: true),
            //     );
            //   },
            // ),
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if((state.paymentInfo?.promoCode?.discount ?? 0.00) <= 0) return SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildRow(
                      context: context,
                      title: 'Promo \'${state.promoCode}\'',
                      amount: '-${state.paymentInfo?.promoCode?.discount?.asNZDFormat(fallback: 'NZD \$0.00') ?? ''}',
                      isDiscount: true),
                );
              },
            ),
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if((state.paymentInfo?.pricing?.dwCreditAmount?.amountToUse ?? 0.00) <= 0) return SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildRow(
                      context: context,
                      title: 'DW Credit',
                      amount: '-${state.paymentInfo?.pricing?.dwCreditAmount?.amountToUse?.asNZDFormat(fallback: 'NZD \$0.00') ?? ''}',
                      isDiscount: true),
                );
              },
            ),
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if((state.paymentInfo?.pricing?.dwCashAmount?.amountToUse ?? 0.00) <= 0) return SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildRow(
                      context: context,
                      title: 'DW Cash Amount',
                      amount: '-${state.paymentInfo?.pricing?.dwCashAmount?.amountToUse?.asNZDFormat(fallback: 'NZD \$0.00') ?? ''}',
                      isDiscount: true),
                );
              },
            ),
            SizedBox(height: 8),
            _buildRow(context: context, title: 'Shipping', amount: 'Free'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17.0),
              child: Divider(color: appColors.silverSand, height: 1),
            ),
            _buildTotal(context),
            SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow({required BuildContext context,
    required String title,
    required String amount,
    bool isDiscount = false}) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w400,
              color: isDiscount ? appColors.vividBlue : appColors.outerSpace,
            ),
          ),
        ),
        Text(
          amount,
          style: AppStyles.of(context).copyWith(
            fontSize: 14,
            fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w400,
            color: isDiscount ? appColors.vividBlue : appColors.outerSpace,
          ),
        ),
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
        BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                    'NZD ',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: appColors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                    state.paymentInfo?.pricing?.totalToPay?.asDFormat(fallback: '\$0.00'),
                    style: AppStyles.of(context).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: appColors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
