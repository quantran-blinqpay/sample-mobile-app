import 'dart:async';

import 'package:designerwardrobe/src/components/bottom_sheet/bottom_sheet.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/complete_purchase_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/my_address_response.dart';
import 'package:designerwardrobe/src/features/payment/presentation/bottomsheets/payment_address/payment_address.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressList extends StatefulWidget {
  final String selectedAddressId;

  const AddressList({super.key, required this.selectedAddressId});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {

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
        if(state.addresses?.isEmpty ?? true) {
          return SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...state.addresses!.map(
              (e) => _buildItemWidget(
                context: context,
                address: e,
              ),
            ),
            InkWell(
              onTap: () async {
                await showFMBS(
                    context: context,
                    builder: (builder) => BlocProvider.value(
                          value: context.read<PaymentCubit>(),
                          // Reuse the same cubit
                          child: PaymentWrapperAddress(),
                        )).then((address) {
                      if (address != null) {
                        context.read<PaymentCubit>().updateAddress(address);
                        // cityController.text = city;
                      }
                    },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  children: const [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Add new address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDefaultAddress({
    required BuildContext context,
    required AddressData address,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          context.read<PaymentCubit>().selectAddress(address);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: appColors.lavender,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        address.deliverTo ?? '',
                        style: AppStyles.of(context)
                            .copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      TextSpan(
                        text: ', ${address.street}, ${address.suburb}, ${address.city} ${address.postcode}',
                        style: AppStyles.of(context)
                            .copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: appColors.black
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(width: 15),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Default',
                    style: AppStyles.of(context)
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget({
    required BuildContext context,
    required AddressData address,
  }) {
    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state){
      return (state.selectedAddress?.id ?? '') == address.id
          ? _buildDefaultAddress(
              context: context,
              address: address)
          : _buildOptionItem(
              context: context,
              address: address,
        );
    });
  }

  Widget _buildOptionItem({
    required BuildContext context,
    required AddressData address,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          _debounce?.cancel();
          _debounce = Timer(Duration(milliseconds: 300), () {
            context.read<PaymentCubit>().selectAddress(address);
            context.read<PaymentCubit>().getPaymentInfo();
          });
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: SizedBox(
                        width: 21,
                        height: 21,
                        child: SvgPicture.asset(
                            (state.selectedAddress?.id ?? '') == address.id ? icRadioSelected : icRadio),
                      ),
                    );
                  },
                ), // space to align with radio
                Expanded(
                  child: Text(
                    '${address.deliverTo}, ${address.street}, ${address.suburb}, ${address.city} ${address.postcode}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: appColors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddressPresenter {
  int id;
  String name;
  String addressLine1;
  String addressLine2;

  AddressPresenter({
    required this.id,
    required this.name,
    required this.addressLine1,
    required this.addressLine2,
  });
}
