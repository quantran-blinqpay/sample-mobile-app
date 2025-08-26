import 'dart:async';

import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/extensions/amount.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplyDWCash extends StatefulWidget {
  const ApplyDWCash({super.key});

  @override
  State<ApplyDWCash> createState() => _ApplyDWCashState();
}

class _ApplyDWCashState extends State<ApplyDWCash> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _debounce?.cancel();
            _debounce = Timer(Duration(milliseconds: 300), () {
              context.read<PaymentCubit>().updateUseDWCash();
              context.read<PaymentCubit>().getPaymentInfo();
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: Image.asset(
                    !state.useDWCash ? icCheckbox : icCheckboxSelected),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Apply DW Cash?',
                  style: AppStyles.of(context).copyWith(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  return Text(
                    state.paymentInfo
                        ?.pricing
                        ?.dwCashAmount
                        ?.amount
                        ?.asDFormat(fallback: '\$0.00') ?? '',
                    style: AppStyles.of(context).copyWith(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}