// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/form/app_form.dart';
import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/components/text_field/app_text_form_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/input_formatters/strict_decimal_inputf.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/core/utils/text_utils.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class CreatePrice extends StatefulWidget {
  const CreatePrice({
    super.key,
    required this.sellController,
    required this.originalController,
    required this.focusNode,
  });

  final TextEditingController sellController;
  final TextEditingController originalController;
  final FocusNode focusNode;

  @override
  State<CreatePrice> createState() => _CreatePriceState();
}

class _CreatePriceState extends State<CreatePrice> {
  late AppColors appColors;
  Timer? _debounce;
  final Duration _debounceDuration = Duration(milliseconds: 500);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  double calculatePositionPercent({
    required double min,
    required double max,
    required double current,
  }) {
    if (max == min) return 0.0;
    return ((current - min) / (max - min));
  }

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocConsumer<CreateListingCubit, CreateListingState>(
      listenWhen: (prev, current) =>
          prev.sellingPrice != current.sellingPrice ||
          prev.originalPrice != current.originalPrice,
      listener: (context, s) {
        TextUtils.setTextSafely(widget.sellController, s.sellingPrice ?? '');
        TextUtils.setTextSafely(
            widget.originalController, s.originalPrice ?? '');
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Text(
                'Price',
                style: AppStyles.of(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (context
                    .read<CreateListingCubit>()
                    .canCallPriceRecommendation() ??
                false)
              _buildPriceRecommendWidget(state, context),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selling price',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: appColors.darkGray,
                    ),
                  ),
                  SizedBox(height: 6),
                  _buildSelectTextfield(
                    context,
                    (v) {
                      context.read<CreateListingCubit>().updateSellingPrice(v);

                      _debounce?.cancel();
                      _debounce = Timer(_debounceDuration, () {
                        context
                            .read<CreateListingCubit>()
                            .getCommission(v, state.nzShippingPrice);

                        final number = double.tryParse(v);
                        if (number != null) {
                          context
                              .read<CreateListingCubit>()
                              .updateSellingPrice(number.toStringAsFixed(2));
                        }
                      });
                    },
                    widget.sellController,
                    focusNode: widget.focusNode,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return FTextFieldStatus(
                            status: TFStatus.error, message: '');
                      } else {
                        return FTextFieldStatus(
                            status: TFStatus.normal, message: null);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Original price ',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: appColors.darkGray,
                              ),
                            ),
                            TextSpan(
                              text: '(optional)',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: appColors.darkGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO_quangdm show webview
                        },
                        child: Container(
                          color: appColors.white,
                          padding: EdgeInsets.fromLTRB(12, 1, 4, 1),
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
                  SizedBox(height: 6),
                  _buildSelectTextfield(
                    context,
                    (v) {
                      context.read<CreateListingCubit>().updateOriginalPrice(v);

                      _debounce?.cancel();
                      _debounce = Timer(_debounceDuration, () {
                        final number = double.tryParse(v);
                        if (number != null) {
                          context
                              .read<CreateListingCubit>()
                              .updateOriginalPrice(number.toStringAsFixed(2));
                        }
                      });
                    },
                    widget.originalController,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPriceRecommendWidget(
      CreateListingState state, BuildContext context) {
    final dataPrice = state.dataPriceRecommend?.prices;

    if (dataPrice?.min != null &&
        dataPrice?.max != null &&
        dataPrice?.median != null &&
        state.fetchPriceStatus != ProgressStatus.failure) {
      return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xffF5F9FF),
          border: Border.all(color: Color(0xffDEEAFC)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Shimmer(
                  enabled: state.fetchPriceStatus == ProgressStatus.inProgress,
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFFFF37D7),
                      Color(0xFF7B00FF),
                      Color(0xFF0022EC),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  child: SvgPicture.asset(
                    Assets.svgs.icAi,
                    width: 16,
                    height: 16,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  state.fetchPriceStatus == ProgressStatus.inProgress
                      ? 'Looking at recent sales...'
                      : 'AI Price Suggestion: \$${(dataPrice?.median ?? 0).toStringAsFixed(2)}*',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[
                          Color(0xFFFF37D7),
                          Color(0xFF7B00FF),
                          Color(0xFF0022EC),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (state.fetchPriceStatus == ProgressStatus.inProgress)
              _buildLoadingAI(context)
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    padding: EdgeInsets.zero,
                    percent: calculatePositionPercent(
                      min: (dataPrice?.min ?? 0).toDouble(),
                      max: (dataPrice?.max ?? 0).toDouble(),
                      current: dataPrice?.median ?? 0,
                    ),
                    animation: true,
                    animateFromLastPercent: true,
                    alignment: MainAxisAlignment.center,
                    backgroundColor: Color(0xFFE6E7EB),
                    linearGradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFFFF37D7),
                        Color(0xFF7B00FF),
                        Color(0xFF0022EC),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    barRadius: const Radius.circular(10),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${(dataPrice?.min ?? 0).toStringAsFixed(2)}',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$${(dataPrice?.max ?? 0).toStringAsFixed(2)}',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedAppButton(
                        onPressed: () {
                          context.read<CreateListingCubit>().updateSellingPrice(
                              (dataPrice?.median ?? 0).toStringAsFixed(2));
                        },
                        bgColor: appColors.black,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        radius: 100,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Use this price(\$${(dataPrice?.median ?? 0).toStringAsFixed(2)})',
                                style: AppStyles.of(context).copyWith(
                                  fontSize: 12.6,
                                  fontWeight: FontWeight.w500,
                                  color: appColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedAppButton(
                        onPressed: () {
                          widget.focusNode.requestFocus();
                        },
                        bgColor: appColors.white,
                        padding: EdgeInsets.zero,
                        radius: 100,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27),
                            border:
                                Border.all(color: appColors.black, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Enter my own price',
                                style: AppStyles.of(context).copyWith(
                                  fontSize: 12.6,
                                  fontWeight: FontWeight.w500,
                                  color: appColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '* Based on recent similar sales',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: appColors.dimGray,
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              )
          ],
        ),
      );
    }

    return SizedBox();
  }

  Column _buildLoadingAI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmer(
          width: MediaQuery.of(context).size.width / 4,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
        AppShimmer(
          width: MediaQuery.of(context).size.width / 3,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
        AppShimmer(
          width: MediaQuery.of(context).size.width / 2,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
        AppShimmer(
          width: MediaQuery.of(context).size.width / 1,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
      ],
    );
  }

  AppTextFormField _buildSelectTextfield(
    BuildContext context,
    Function(String)? onChanged,
    TextEditingController controller, {
    FocusNode? focusNode,
    FTextFieldStatus? Function(String?)? validator,
  }) {
    final isFromAud = context.read<AuthCubit>().state.isFromAud;
    return AppTextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      controller: controller,
      hintText: '0.00',
      inputFormatters: [StrictDecimalInputFormatter(decimalRange: 2)],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      prefixIcon: Text(
        isFromAud ?? false ? 'AUD \$' : 'NZD \$',
        style: AppStyles.of(context).copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      validator: validator,
    );
  }
}
