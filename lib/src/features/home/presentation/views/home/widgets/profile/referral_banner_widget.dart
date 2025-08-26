import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReferralBannerWidget extends StatelessWidget {
  const ReferralBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return !state.isSignedIn
                  ? SizedBox.shrink()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ColoredBox(
                          color: appColors.gainsboro,
                          child: SizedBox(
                            height: 16,
                            width: double.infinity,
                          ),
                        ),
                        ColoredBox(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ColoredBox(
                              color: Colors.white,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: appColors.skyBlue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SvgPicture.asset(icHandHeard,
                                            width: 40, height: 40),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Refer your friends & earn reward',
                                              style: AppStyles.of(context)
                                                  .copyWith(
                                                      fontSize: 12.6,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: appColors.black),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Share your personal referral code & earn together.',
                                                    style: AppStyles.of(context)
                                                        .copyWith(
                                                      fontSize: 12.6,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: appColors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' Get started now',
                                                    style: AppStyles.of(context)
                                                        .copyWith(
                                                      fontSize: 12.6,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: appColors.black,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            },
          );
        },
        // Or, uncomment the following line:
        childCount: 1,
      ),
    );
  }
}
