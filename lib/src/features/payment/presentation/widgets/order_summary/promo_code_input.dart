import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoCodeInput extends StatelessWidget {
  const PromoCodeInput({super.key});

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
                    flex: 4,
                    child: CustomTextFormField(
                      controller: context.read<PaymentCubit>().promoCodeController,
                      backgroundColor: Colors.transparent,
                      keyboardType: TextInputType.name,
                      hintText: 'Enter it here',
                      onChanged: (text) {
                        context.read<PaymentCubit>().updatePromoCode(text);
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return AppButton(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          title: 'Apply',
                          onPressed: (state.promoCode?.isEmpty ?? true)
                              ? null
                              : () {
                                context.read<PaymentCubit>().getPaymentInfo();
                          },
                          backgroundColor: (state.promoCode?.isEmpty ?? true)
                              ? appColors.black.withAlpha(80)
                              : appColors.black,
                          textColor: appColors.white,
                          radius: 5,
                        );
                      },
                    ),
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
