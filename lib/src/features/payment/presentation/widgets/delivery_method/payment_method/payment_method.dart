import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:qwid/src/features/payment/presentation/widgets/delivery_method/arrow_box.dart';
import 'package:qwid/src/features/payment/presentation/widgets/delivery_method/payment_method/apply_dw_cash.dart';
import 'package:qwid/src/features/payment/presentation/widgets/delivery_method/payment_method/credit_debit_cards.dart';
import 'package:qwid/src/features/payment/presentation/widgets/delivery_method/payment_method/other_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  bool _isCollapsed = true;
  int _selectedId = 1;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isCollapsed = !_isCollapsed;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                    'Payment method', style: AppStyles.of(context).copyWith(
                  color: appColors.outerSpace,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
              ),
              ArrowBox(isDown: _isCollapsed),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _isCollapsed ? _buildCollapseLayout(context) : _buildExpandLayout(
            context),
      ],
    );
  }

  Widget _buildCollapseLayout(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state.selectedCards == null) {
          return Text(
            '',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          );
        }
        return Row(
          children: [
            // VISA logo inside a rounded box
            Container(
              width: 43,
              height: 27,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white,
                border: Border.all(color: appColors.rhino),
              ),
              child: Image.asset(
                icPaymentVisa,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            // Bank name + masked number
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                return Text(
                  'ANZ  .....  ${state.selectedCards?.last4}',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildExpandLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return CreditDebitCards(
              onTap: () {
                setState(() {
                  _selectedId = 1;
                });
              },
              paymentMethodSelected: _selectedId == 1,
            );
          },
        ),
        const SizedBox(height: 10),
        _buildAfterpayLayout(context),
        const SizedBox(height: 10),
        _buildLaybuyLayout(context),
        const SizedBox(height: 10),
        _buildZipLayout(context),
        const SizedBox(height: 17),
        _buildApplyDWCash(context),
      ],
    );
  }

  Widget _buildAfterpayLayout(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.5,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedId = 2;
            });
          },
          child: OtherPaymentMethod(
            id: 2,
            logoPath: icPaymentAfterPay,
            name: 'Afterpay',
            paymentMethodSelected: _selectedId == 2,
          ),
        ),
      ),
    );
  }

  Widget _buildLaybuyLayout(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.5,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedId = 3;
            });
          },
          child: OtherPaymentMethod(
            id: 2,
            logoPath: icPaymentLaybuy,
            name: 'Laybuy by Klarna',
            paymentMethodSelected: _selectedId == 3,
          ),
        ),
      ),
    );
  }

  Widget _buildZipLayout(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.5,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedId = 4;
            });
          },
          child: OtherPaymentMethod(
            id: 2,
            logoPath: icPaymentZip,
            name: 'Zip',
            paymentMethodSelected: _selectedId == 4,
          ),
        ),
      ),
    );
  }

  Widget _buildApplyDWCash(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return ApplyDWCash();
  }

}