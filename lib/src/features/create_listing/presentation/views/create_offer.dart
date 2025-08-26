// ignore_for_file: must_be_immutable

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/checkbox/custom_checkbox.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreateOffer extends StatelessWidget {
  CreateOffer({super.key});

  late AppColors appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocBuilder<CreateListingCubit, CreateListingState>(
      buildWhen: (previous, current) =>
          previous.isOfferBuyNow != current.isOfferBuyNow,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Text(
                'Offer Buy Now, Pay Later?',
                style: AppStyles.of(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Boost your changes of selling by offering Buy Now, Pay Later ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "(you're still paid upfront)",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '. Buyers can still use credit or debit cards.',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              decoration: BoxDecoration(
                border: Border.all(color: appColors.silverSand),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckbox(
                    value: state.isOfferBuyNow ?? false,
                    onChanged: (v) {
                      context.read<CreateListingCubit>().toogleOfferBuyNow(v!);
                    },
                    borderColor: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                    child: SvgPicture.asset(Assets.svgs.icBuyNow),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  'Buy now, pay later',
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(8, 6, 6, 0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFFFC7AD),
                                    Color(0xFFFFC0EF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Buyers Love',
                                style: AppStyles.of(context).copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: appColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          '4.95% transaction fee applies',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 13,
                            color: appColors.dimGray,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            Image.asset(
                              Assets.images.imgAfterpayFull.path,
                              height: 24,
                            ),
                            Image.asset(
                              Assets.images.imgLaybuyFull.path,
                              height: 24,
                            ),
                            Image.asset(
                              Assets.images.imgZipFull.path,
                              height: 24,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
          ],
        );
      },
    );
  }
}
