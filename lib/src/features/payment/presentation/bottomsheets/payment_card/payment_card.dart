import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/bottom_sheet/bottom_sheet.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:designerwardrobe/src/features/payment/presentation/bottomsheets/payment_card/payment_card_cubit.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:designerwardrobe/src/features/payment/presentation/webview/payment_webview.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/arrow_box.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/order_summary/add_to_saved_card.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentWrapperCard extends StatelessWidget {
  const PaymentWrapperCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentCardCubit>(create: (context) => PaymentCardCubit(
            di<PaymentRepository>())
          ..updateCardNumber('411111111111111')
          ..updateExpiredDate('02/28')
          ..updateSecurityCode('888')
          ..updateNameOnCard('Quan Tran')),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PaymentCardCubit, PaymentCardState>(
              listener: (context, state) {
                if(state.submitCreditCardStatus == ProgressStatus.success) {
                  context.router.pop(state.creditCard);
                  _showMessage(message: 'Success!', context: context);
                } else if(state.submitCreditCardStatus == ProgressStatus.failure) {
                  context.router.pop();
                  _showMessage(message: 'Submit your credit card has been failed!', context: context);
                } else if(state.submitCreditCardStatus == ProgressStatus.direct) {
                  _start3DSVerification(context);
                }
                /// do something here
              }),
        ], child: PaymentCard(),
      ),
    );
  }

  Future<void> _start3DSVerification(BuildContext context) async {
    context.router.push(PaymentWebViewScreenRoute(
      initialUrl: context.read<PaymentCardCubit>().state.href ?? '',
    )).then((result) {
      if (result == true) {
        // Success, url contained windcave/success
        context.read<PaymentCardCubit>().approveTemporaryCreditCard();
      } else {
        // User closed or failed
        _showMessage(message: '3DS verify failed!', context: context);
      }
    });
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: double.infinity,
            child: Text(
              'Add card',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          actions: [
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
            SizedBox(width: 7),
            Container(
              width: 43,
              height: 27,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white,
                border: Border.all(color: appColors.rhino),
              ),
              child: Image.asset(
                icPaymentMastercard,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 15),
            IconButton(
              padding: EdgeInsets.all(5),
              icon: SvgPicture.asset(
                Assets.svgs.icClose,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 15),
            _buildCardNumber(context),
            SizedBox(height: 15),
            _buildExpiredData(context),
            SizedBox(height: 15),
            _buildSecurityCode(context),
            SizedBox(height: 15),
            _buildName(context),
            SizedBox(height: 15),
            _buildBillAddress(context),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: AddToSavedCard(),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                //do something here
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Cancel',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: appColors.dimGray,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: BlocBuilder<PaymentCardCubit, PaymentCardState>(
                builder: (context, state) {
                  return BlocBuilder<PaymentCubit, PaymentState>(
                    builder: (context, paymentState) {
                      return AppButton(
                        isLoading: state.submitCreditCardStatus == ProgressStatus.inProgress,
                        title: 'Save card',
                        onPressed: (paymentState.isWindcave || paymentState.isBraintree)
                            && (state.cardNumber?.isNotEmpty ?? false)
                            && (state.expiredDate?.isNotEmpty ?? false)
                            && (state.securityCode?.isNotEmpty ?? false)
                            && (state.nameOnCard?.isNotEmpty ?? false)
                            ? () {
                                if(paymentState.isWindcave) {
                                  context.read<PaymentCardCubit>().submitCreditCardToWindCave(
                                      cardNumber: state.cardNumber ?? '',
                                      expiredDate: state.expiredDate ?? '',
                                      securityCode: state.securityCode ?? '',
                                      nameOnCard: state.nameOnCard ?? '',
                                      totalToPay: paymentState.paymentInfo?.pricing?.totalToPay ?? 0.0,
                                      currency: paymentState.paymentInfo?.pricing?.currency ?? '');
                                } else if (paymentState.isBraintree) {
                                  context.read<PaymentCardCubit>().submitCreditCardToBraintree(
                                      cardNumber: state.cardNumber ?? '',
                                      expiredDate: state.expiredDate ?? '',
                                      securityCode: state.securityCode ?? '',
                                      nameOnCard: state.nameOnCard ?? '');
                                }
                              }
                            : null,
                        backgroundColor: (paymentState.isWindcave || paymentState.isBraintree)
                            && (state.cardNumber?.isNotEmpty ?? false)
                            && (state.expiredDate?.isNotEmpty ?? false)
                            && (state.securityCode?.isNotEmpty ?? false)
                            && (state.nameOnCard?.isNotEmpty ?? false)
                            ? appColors.black
                            : appColors.black.withAlpha(80),
                        textColor: appColors.white,
                        radius: 5,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 40,),
          ],
        ),
      ],
    );
  }

  final TextEditingController cardNumberController = TextEditingController(
      text: '411111111111111');
  Widget _buildCardNumber(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card number',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              backgroundColor: Colors.transparent,
              onTap: () async {
                // do something here
              },
              onChanged: (text) {
                context.read<PaymentCardCubit>().updateCardNumber(text);
              },
              controller: cardNumberController,
              hintText: '',
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController expiredDateController = TextEditingController(
      text: '02/28');
  Widget _buildExpiredData(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expiry date (MM/YY)',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              backgroundColor: Colors.transparent,
              onTap: () async {
                // do something here
              },
              onChanged: (text) {
                context.read<PaymentCardCubit>().updateExpiredDate(text);
              },
              controller: expiredDateController,
              hintText: '',
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController securityCodeController = TextEditingController(
      text: '888');
  Widget _buildSecurityCode(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security code (CVC)',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              backgroundColor: Colors.transparent,
              onTap: () async {
                // do something here
              },
              onChanged: (text) {
                context.read<PaymentCardCubit>().updateSecurityCode(text);
              },
              controller: securityCodeController,
              hintText: '',
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController nameController = TextEditingController(text:
      'Quan Tran');
  Widget _buildName(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name on card',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              backgroundColor: Colors.transparent,
              onTap: () async {
                // do something here
              },
              onChanged: (text) {
                context.read<PaymentCardCubit>().updateNameOnCard(text);
              },
              controller: nameController,
              hintText: '',
              keyboardType: TextInputType.name,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBillAddress(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Billing address',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.outerSpace,
            ),
          ),
          SizedBox(height: 9),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Aidan Bartlett',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: appColors.black,
                        ),
                      ),
                      TextSpan(
                        text: ', 98 Owairaka Ave, Mount Albert, AUK, 1025',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: appColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ArrowBox(isDown: true),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}