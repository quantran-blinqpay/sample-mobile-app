import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/arrow_box.dart';
import 'package:designerwardrobe/src/features/payment/presentation/widgets/delivery_method/ship_to/address_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipToWidget extends StatefulWidget {
  const ShipToWidget({super.key});

  @override
  State<ShipToWidget> createState() => _ShipToWidgetState();
}

class _ShipToWidgetState extends State<ShipToWidget> {
  bool _isCollapsed = true;

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
                child: Text('Ship to',
                    style: AppStyles.of(context).copyWith(
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
        _isCollapsed
            ? _buildCollapseLayout(context)
            : _buildExpandLayout(context),
      ],
    );
  }

  Widget _buildCollapseLayout(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: state.selectedAddress?.deliverTo ?? '',
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: appColors.black,
                ),
              ),
              TextSpan(
                text:
                    ', ${state.selectedAddress?.street}, ${state.selectedAddress?.suburb}, ${state.selectedAddress?.city} ${state.selectedAddress?.postcode}',
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpandLayout(BuildContext context) {
    return const AddressList(selectedAddressId: '');
  }
}
