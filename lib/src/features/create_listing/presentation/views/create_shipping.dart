// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/switch/app_switch.dart';
import 'package:qwid/src/components/switch/custom_switch.dart';
import 'package:qwid/src/components/text_field/app_text_form_field.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/input_formatters/strict_decimal_inputf.dart';
import 'package:qwid/src/core/utils/text_utils.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class CreateShipping extends StatefulWidget {
  const CreateShipping({
    super.key,
    required this.nzController,
    required this.auController,
  });

  final TextEditingController nzController;
  final TextEditingController auController;

  @override
  State<CreateShipping> createState() => _CreateShippingState();
}

class _CreateShippingState extends State<CreateShipping> {
  late AppColors appColors;
  final dataSiteSetting = GetIt.instance<HelperCubit>().state.siteSetting;
  Timer? _debounce;
  final Duration _debounceDuration = Duration(milliseconds: 500);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocConsumer<CreateListingCubit, CreateListingState>(
      listenWhen: (prev, current) =>
          prev.nzShippingPrice != current.nzShippingPrice ||
          prev.auShippingPrice != current.auShippingPrice,
      listener: (context, s) {
        TextUtils.setTextSafely(widget.nzController, s.nzShippingPrice ?? '');
        TextUtils.setTextSafely(widget.auController, s.auShippingPrice ?? '');
      },
      builder: (context, state) {
        /**
         * default shipping cho NZ
         * NZ -> NZ = 0
         * NZ -> AU lấy từ site-settings data.global.default_shipping_fee.default_nz_to_au_fee_for_nz_user
         * ---
         * default shipping cho AU
         * AU -> AU = 10
         * AU -> NZ = 20 */
        final isFromAud = context.read<AuthCubit>().state.isFromAud;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Text(
                'Shipping',
                style: AppStyles.of(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Your shipping price will be added to your listing total. Leave blank to offer free shipping',
                style: AppStyles.of(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            isFromAud ?? false
                ? _buildFromAud(context, state)
                : _buildFromNzd(context, state),
          ],
        );
      },
    );
  }

  Column _buildFromAud(BuildContext context, CreateListingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Australia',
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
                  context.read<CreateListingCubit>().updateAuShippingPrice(v);

                  _debounce?.cancel();
                  _debounce = Timer(_debounceDuration, () {
                    context
                        .read<CreateListingCubit>()
                        .getCommission(state.sellingPrice, v);

                    final number = double.tryParse(v);
                    if (number != null) {
                      context
                          .read<CreateListingCubit>()
                          .updateAuShippingPrice(number.toStringAsFixed(2));
                    }
                  });
                },
                widget.auController,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You can edit the suggested shipping price',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Zealand',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: state.isUseShipping ?? false
                          ? appColors.darkGray
                          : appColors.neutralGray,
                    ),
                  ),
                  AppSwitch(
                    controller:
                        SwitchController(value: state.isUseShipping ?? false),
                    onChanged: (value) {
                      context
                          .read<CreateListingCubit>()
                          .toogleUseShipping(value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              _buildSelectTextfield(
                context,
                (v) {
                  context.read<CreateListingCubit>().updateNzShippingPrice(v);

                  _debounce?.cancel();
                  _debounce = Timer(_debounceDuration, () {
                    final number = double.tryParse(v);
                    if (number != null) {
                      context
                          .read<CreateListingCubit>()
                          .updateNzShippingPrice(number.toStringAsFixed(2));
                    }
                  });
                },
                widget.nzController,
                enabled: state.isUseShipping ?? false,
              ),
              if (state.isUseShipping ?? false)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 16, 0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'You can edit the suggested shipping price',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "You've disabled shipping to ",
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: appColors.mediumGray,
                          ),
                        ),
                        TextSpan(
                          text: 'New Zealand',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: appColors.mediumGray,
                          ),
                        ),
                        TextSpan(
                          text: ", but you can enable it again later.",
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: appColors.mediumGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildFromNzd(BuildContext context, CreateListingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Zealand',
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
                  context.read<CreateListingCubit>().updateNzShippingPrice(v);

                  _debounce?.cancel();
                  _debounce = Timer(_debounceDuration, () {
                    context
                        .read<CreateListingCubit>()
                        .getCommission(state.sellingPrice, v);

                    final number = double.tryParse(v);
                    if (number != null) {
                      context
                          .read<CreateListingCubit>()
                          .updateNzShippingPrice(number.toStringAsFixed(2));
                    }
                  });
                },
                widget.nzController,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Book a Courier ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:
                          'estimate is \$${'${state.dataDwpost?.nzToNz?.first.price ?? 0}'}',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
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
              if (state.dataDwpost?.nzToNz != null)
                GestureDetector(
                  onTap: () {
                    final v = '${state.dataDwpost?.nzToNz?.first.price ?? 0}';

                    widget.nzController.text = v;
                    context.read<CreateListingCubit>().updateNzShippingPrice(v);
                  },
                  child: Container(
                    color: appColors.white,
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    child: Text(
                      'Apply',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            children: [
              Text(
                'Rural buyers pay an additional \$${dataSiteSetting?.rural?.price?.forBuyer}',
                style: AppStyles.of(context).copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Australia',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: state.isUseShipping ?? false
                          ? appColors.darkGray
                          : appColors.neutralGray,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: state.isUseShipping ?? false
                          ? appColors.coralBlue
                          : Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      state.isUseShipping ?? false ? 'NEW' : 'DISABLED',
                      style: AppStyles.of(context).copyWith(
                        color: state.isUseShipping ?? false
                            ? appColors.vividBlue
                            : appColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Spacer(),
                  AppSwitch(
                    controller:
                        SwitchController(value: state.isUseShipping ?? false),
                    onChanged: (value) {
                      context
                          .read<CreateListingCubit>()
                          .toogleUseShipping(value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              _buildSelectTextfield(
                context,
                (v) {
                  context.read<CreateListingCubit>().updateAuShippingPrice(v);

                  _debounce?.cancel();
                  _debounce = Timer(_debounceDuration, () {
                    final number = double.tryParse(v);
                    if (number != null) {
                      context
                          .read<CreateListingCubit>()
                          .updateAuShippingPrice(number.toStringAsFixed(2));
                    }
                  });
                },
                widget.auController,
                enabled: state.isUseShipping ?? false,
              ),
              if (state.isUseShipping ?? false)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 16, 0),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Book a Courier ',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'estimate is \$${state.dataDwpost?.nzToAu?.first.price ?? 0}',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
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
                      if (state.dataDwpost?.nzToAu != null)
                        GestureDetector(
                          onTap: () {
                            final v =
                                '${state.dataDwpost?.nzToAu?.first.price ?? 0}';

                            widget.auController.text = v;
                            context
                                .read<CreateListingCubit>()
                                .updateAuShippingPrice(v);
                          },
                          child: Container(
                            color: appColors.white,
                            padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Text(
                              'Apply',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "You've disabled shipping to ",
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: appColors.mediumGray,
                          ),
                        ),
                        TextSpan(
                          text: 'Australia',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: appColors.mediumGray,
                          ),
                        ),
                        TextSpan(
                          text: ", but you can enable it again later.",
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: appColors.mediumGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  AppTextFormField _buildSelectTextfield(
    BuildContext context,
    Function(String)? onChanged,
    TextEditingController controller, {
    bool enabled = true,
  }) {
    final isFromAud = context.read<AuthCubit>().state.isFromAud;
    return AppTextFormField(
      enabled: enabled,
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
          color: enabled ? appColors.black : appColors.dimGray,
        ),
      ),
    );
  }
}
