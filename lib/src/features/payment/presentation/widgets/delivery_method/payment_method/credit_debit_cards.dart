import 'package:cached_network_image/cached_network_image.dart';
import 'package:designerwardrobe/src/components/bottom_sheet/bottom_sheet.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/utils/card_util.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/windcave_card_response.dart';
import 'package:designerwardrobe/src/features/payment/presentation/bottomsheets/payment_card/payment_card.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditDebitCards extends StatefulWidget {
  const CreditDebitCards({
    required this.onTap,
    required this.paymentMethodSelected,
    super.key,
  });

  final GestureTapCallback onTap;
  final bool paymentMethodSelected;

  @override
  State<CreditDebitCards> createState() => _CreditDebitCardsState();
}

class _CreditDebitCardsState extends State<CreditDebitCards> {

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent section radio
            GestureDetector(
              onTap: widget.onTap,
              child: Row(
                children: [
                  SizedBox(
                    width: 21,
                    height: 21,
                    child: SvgPicture.asset(
                        widget.paymentMethodSelected ? icRadioSelected: icRadio
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Credit/debit card',
                    style: AppStyles.of(context).copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),


            // Card items
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if(state.cards?.isEmpty ?? true) {
                  return SizedBox.shrink();
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: state.cards!.map((e) => buildCardItem(card: e)).toList()
                );
              },
            ),
            const SizedBox(height: 8),
            // Add new card link
            InkWell(
              onTap: () async {
                await showFMBS(
                context: context,
                builder: (builder) => BlocProvider.value(
                  value: context.read<PaymentCubit>(), // Reuse the same cubit
                  child: PaymentWrapperCard(),
                )).then((creditCard) {
                  if (creditCard != null) {
                    context.read<PaymentCubit>().updateCreditCard(creditCard);
                    // cityController.text = city;
                  }
                },
                );
              },
              child: Row(
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 12),
                  Text(
                    'Add a debit or credit card',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardItem({
    required WindcaveCardData card,
    // required int id,
    // required String logoPath,
    // required String bankName,
    // required String last4Digits,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<PaymentCubit>().selectWindcaveCard(card),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: (state.selectedCards?.token == card.token) ? appColors.lavender: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 21,
                    height: 21,
                    child: SvgPicture.asset(
                        (state.selectedCards?.token == card.token)
                            ? icRadioFillSelected
                            : icRadio
                    ),
                  ),
                  const SizedBox(width: 12),
                  // VISA logo inside a rounded box
                  Container(
                    width: 43,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white,
                      border: Border.all(color: appColors.rhino),
                    ),
                    child: (card.image_url != null) ? AppImage(
                      imageUrl: card.image_url ?? '',
                      fit: BoxFit.contain,
                    ) : Image.asset(
                      CardUtils.fromCardType(card.card_type ?? '').cardLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Bank name + masked number
                  Expanded(
                    child: Text(
                      'ANZ  .....  ${card.last4 ?? ''}',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  state.selectedCards?.token == card.token ? Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Default',
                      style: AppStyles.of(context).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ) : SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}