import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/loading_indicator/app_shimmer.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/payment/presentation/bottomsheets/payment_address/payment_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressInputField extends StatefulWidget {
  const AddressInputField({super.key, required this.addressController});

  final TextEditingController addressController;

  @override
  State<AddressInputField> createState() => _AddressInputFieldState();
}

class _AddressInputFieldState extends State<AddressInputField> {

  bool _isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: appColors.silverSand),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomTextFormField(
                  height: 50,
                  controller: widget.addressController,
                  backgroundColor: Colors.transparent,
                  keyboardType: TextInputType.name,
                  hintText: '',
                  onChanged: (text) {
                    context.read<PaymentAddressCubit>().updateAddress(text);
                    if(text.isEmpty){
                      setState(() {
                        _isCollapsed = true;
                      });
                      return;
                    }
                    setState(() {
                      _isCollapsed = false;
                    });
                    context.read<PaymentAddressCubit>().lookupAddress();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(
                      icSearch,
                      width: 20,
                      height: 20,
                      color: appColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<PaymentAddressCubit, PaymentAddressState>(
          builder: (context, state) {
            if(_isCollapsed) {
              return const SizedBox.shrink();
            }
            if(state.lookupAddressStatus == ProgressStatus.initial) {
              return const SizedBox.shrink();
            }
            if(state.lookupAddressStatus == ProgressStatus.failure) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: appColors.silverSand),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'SUGGESTION',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appColors.mediumGray,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              Assets.svgs.icClose,
                              width: 12,
                              height: 12,
                            ),
                            onPressed: () {
                              setState(() {
                                _isCollapsed = true;
                              });
                            },
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300, minHeight: 0),
                        child: state.lookupAddressStatus == ProgressStatus.inProgress
                          ? SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppShimmer(width: double.infinity, height: 14, padding: EdgeInsets.symmetric(horizontal: 12.0)),
                                SizedBox(height: 12),
                                AppShimmer(width: double.infinity, height: 14, padding: EdgeInsets.symmetric(horizontal: 12.0)),
                                SizedBox(height: 12),
                                AppShimmer(width: double.infinity, height: 14, padding: EdgeInsets.symmetric(horizontal: 12.0)),
                                SizedBox(height: 12),
                                AppShimmer(width: double.infinity, height: 14, padding: EdgeInsets.symmetric(horizontal: 12.0)),
                                SizedBox(height: 12),
                              ],
                            ),
                          )
                          : ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.suggestions?.length ?? 0,
                            separatorBuilder: (context,
                                index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isCollapsed = true;
                                  });
                                  context.read<PaymentAddressCubit>().updateAddress(state.suggestions?[index].fullAddress ?? '');
                                  context.read<PaymentAddressCubit>().selectAddress(state.suggestions?[index]);
                                  widget.addressController.text = state.suggestions?[index].fullAddress ?? '';
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text(
                                    state.suggestions?[index].fullAddress ?? '',
                                    style: AppStyles.of(context).copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.all(1),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appColors.silverSand,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ColoredBox(
                              color: appColors.lightGray,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'powered by ',
                                        style: AppStyles.of(context).copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: appColors.mediumGray,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Google',
                                        style: AppStyles.of(context).copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: appColors.mediumGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
