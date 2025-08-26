// ignore_for_file: must_be_immutable

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreateEarning extends StatelessWidget {
  CreateEarning({
    super.key,
    required this.onCreateListing,
    required this.onSaveDraft,
  });

  final Function()? onCreateListing;
  final Function()? onSaveDraft;
  late AppColors appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocBuilder<CreateListingCubit, CreateListingState>(
      buildWhen: (previous, current) =>
          previous.buyerPays != current.buyerPays ||
          previous.youllEarn != current.youllEarn,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                child: Text(
                  'Earning breakdown',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildRow(
                context,
                'Buyer pays (including shipping)',
                state.buyerPays ?? '0.00',
              ),
              _buildRow(
                context,
                "You'll earn*",
                state.youllEarn ?? '0.00',
              ),
              CustomDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        '* Excluding payments fees',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // TODO_quangdm show webview
                      },
                      child: Container(
                        color: appColors.white,
                        padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                        child: SvgPicture.asset(
                          Assets.svgs.icQuestion,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            appColors.dimGray,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F9FE),
                  border: Border.all(color: Color(0xFFDEEAFB)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'AI List Assist provides suggestions - please verify size and condition befor listing.  ',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO_quangdm show webview
                          },
                        text: 'Give feedback',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              AppButton(
                onPressed: onCreateListing,
                title: 'CREATE LISTING',
                backgroundColor: appColors.black,
                textColor: appColors.registerTextButtonColor,
                radius: 6,
                fontSize: 14,
              ),
              SizedBox(height: 16),
              AppButton(
                onPressed: onSaveDraft,
                title: 'SAVE DRAFT',
                backgroundColor: appColors.white,
                border: Border.all(color: appColors.black),
                textColor: appColors.black,
                fontSize: 14,
                radius: 6,
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Buy creating a listing you agree to our ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO_quangdm show webview
                        },
                      text: 'terms',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO_quangdm show webview
                        },
                      text: 'delivery policy',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Column _buildRow(BuildContext context, String title, String value) {
    return Column(
      children: [
        CustomDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.of(context).copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                'NZD \$ ',
                style: AppStyles.of(context).copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: AppStyles.of(context).copyWith(
                  fontSize: 13,
                  color: appColors.mediumGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
